import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:story_view/story_view.dart';
import 'package:untitled/Service/mock_data.dart';
import 'package:untitled/models/Match.dart';
import 'package:untitled/models/adBanner.dart';
import 'package:untitled/screens/Story.dart';
import '../Service/data_service.dart';
import '../components/colors.dart'; // Import the colors file
import '../components/story_circle.dart';
import '../models/Club.dart';
import '../models/Moment.dart';
import '../models/News.dart';
import '../models/Story.dart';
import 'StoryViewScreen.dart';
import 'bottom_sheet.dart';
import '../components/full_story_screen.dart'; // Import FullStoryScreen
import '../components/image_slider.dart'; // Import the ImageSlider widget
import '../components/video_component.dart'; // Import the VideoComponent widget
import '../components/match_result_component.dart'; // Import MatchResultComponent widget
import '../components/ads_banner.dart'; // Import AdsBanner widget
import '../components/dynamic_image_grid.dart';
import '../components/news_section.dart';
import '../models/Stream.dart';

class HomeScreen extends StatefulWidget {
  final Function(News) onNewsSelected;
  final StoryController _storyController = StoryController();
  final Function(Club) onTeamSelected;
  final Function(Match) onMatchSelected;
  HomeScreen(
      {Key? key,
      required this.onNewsSelected,
      required this.onTeamSelected,
      required this.onMatchSelected})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true; // Added loading state
  bool isMatchesLoading = true; // Loading state for matches
  final DataService dataService = DataService();
  List<News> newsList = [];
  List<Match> matchesList = [];
  List<StreamItem> streamItems = [];
  List<Story> Stories = [];
  bool isVideosLoading = true;
  bool isAdsLoading = true;
  @override
  void initState() {
    super.initState();
    _fetchNews();
    _fetchMatches();
    _fetchStream();
    _fetchStories();
    _fetchReels();
    _fetchAds();
  }

  Future<void> _fetchStream() async {
    final streamItem = await dataService.fetchStream();
    setState(() {
      //streamItems = streamItem;
      streamItems = streamItem..sort((a, b) => a.id.compareTo(b.id));
    });
  }

  Future<void> _fetchStories() async {
    final storyItem = await dataService.fetchStories();
    print("stories fetched");

    setState(() {
      // Clear the links and titles lists before adding new data
      links.clear();
      titles.clear();

      for (int i = 0; i < storyItem.length; i++) {
        // Create a new inner list for video links of the current story
        List<String> videoLinks = [];

        for (int j = 0; j < storyItem[i].videos!.length; j++) {
          // Access the 'file' property for video links
          videoLinks.add(storyItem[i].videos![j].lien!);
        }

        // Add the inner list of video links to the main links list
        links.add(videoLinks);

        // Add corresponding user title
        titles.add(storyItem[i].name!);
      }

      // Print the results
      print('Links:');
      print(links);
      print('Titles:');
      print(titles);

      Stories = storyItem; // Assuming Stories is defined elsewhere
    });
  }

  Future<void> _fetchNews() async {
    try {
      final fetchedNews = await dataService.fetchNews();
      setState(() {
        // Take only the first 3 items from fetchedNews
        newsList = fetchedNews.take(3).toList();
        print("news: $newsList");
        isLoading = false; // Set loading to false after fetching
      });
    } catch (e) {
      // Handle errors here, e.g., show a SnackBar or an error message
      setState(() {
        isLoading = false; // Stop loading on error
      });
    }
  }

  String _formatTime(String? timeString) {
    if (timeString == null || timeString.isEmpty) return 'TBD';

    // Split the time string into hours and minutes
    final timeParts = timeString.split(':');
    if (timeParts.length != 3)
      return 'TBD'; // Return empty if the format is invalid

    final hours = int.tryParse(timeParts[0]);
    final minutes = int.tryParse(timeParts[1]);

    // Validate hours and minutes
    if (hours == null ||
        minutes == null ||
        hours < 0 ||
        hours > 23 ||
        minutes < 0 ||
        minutes > 59) {
      return 'TBD'; // Return empty if invalid
    }

    // Create a DateTime object
    final dateTime = DateTime.now().copyWith(hour: hours, minute: minutes);

    // Format the DateTime object to 'HH:mm'
    return DateFormat('HH:mm').format(dateTime); // Example: "14:30"
  }

  Future<void> _fetchMatches() async {
    try {
      final fetchedMatches = await dataService.fetchPlayedMatches();

      // Sort the fetched matches by date and time
      fetchedMatches.sort((a, b) {
        if (a.date != null && b.date != null) {
          // First, compare by date
          int dateComparison = b.date!.compareTo(a.date!);
          if (dateComparison != 0) {
            return dateComparison;
          }

          // If dates are the same, compare by time
          if (a.time != null && b.time != null) {
            String timeA = _formatTime(b.time);
            String timeB = _formatTime(a.time);
            return timeA.compareTo(timeB);
          }
        }
        return 0; // Default case if one or both dates/times are null
      });

      // Update state with the sorted list
      setState(() {
        matchesList = fetchedMatches;
        isMatchesLoading =
            false; // Set loading to false after fetching and sorting matches
      });
    } catch (e) {
      print("Error fetching matches for result component: $e");
      setState(() {
        isMatchesLoading = false; // Stop loading on error
      });
    }
  }

  List<Moment> moments = [];

  Future<void> _fetchReels() async {
    try {
      final fetchedMoments = await dataService.fetchReels();
      setState(() {
        moments = fetchedMoments;
        isVideosLoading = false; // Set loading to false after fetching matches
      });
    } catch (e) {
      print("error fetching moments for home screen $e");
      setState(() {
        isVideosLoading = false; // Stop loading on error
      });
    }
  }

  // List of image paths
  List<String> imagePaths = [];

  Future<void> _fetchAds() async {
    try {
      final fetchedAds = await dataService.fetchAds();
      setState(() {
        // Filter ads by place, ensure non-null images, and map to their image paths
        imagePaths = fetchedAds
            .where((ad) =>
                ad.place == "home_swiper" &&
                ad.image != null) // Filter by place and non-null images
            .map((ad) => ad
                .image!) // Use non-null assertion to convert String? to String
            .toList();
        isAdsLoading = false; // Set loading to false after fetching ads
      });
    } catch (e) {
      print("Error fetching ads for home screen: $e");
      setState(() {
        isAdsLoading = false; // Stop loading on error
      });
    }
  }

  List<List<String>> links = [];
  List<String> titles = [];

  final List<List<StoryItem>> storyItemsList = [
    [
      StoryItem.text(
        title: "First Story of User A",
        backgroundColor: Colors.red,
      ),
      StoryItem.inlineImage(
        url: "https://your-image-url.com/image1.jpg",
        controller: StoryController(),
        caption: Text("A great goal!"),
      ),
    ],
    [
      StoryItem.text(
        title: "Breaking news!",
        backgroundColor: Colors.blueAccent,
      ),
      StoryItem.inlineImage(
        url: "https://media.giphy.com/media/l0HUpt2s9Pclgt9Vm/giphy.gif",
        controller: StoryController(),
        caption: Text("Celebration GIF"),
      ),
    ],
    // Add more story sets for other users
  ];

  // Initialize viewedStatuses for each story

  final List<bool> viewedStatuses = [
    true, // Story set 1 has been viewed
    false, // Story set 2 has not been viewed
    true, // Story set 3 has been viewed
    true,
    true,
    // Add more statuses as needed
  ];

  @override
  Widget build(BuildContext context) {
    List<String> videoPaths =
        moments.map((moment) => moment.video).take(4).toList();
    List<String> captions =
        moments.map((moment) => moment.name).take(4).toList();
    print("videopaths");
    print(videoPaths);
    print(captions);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundColor, // Use the gradient here
        ),
        child: ListView.builder(
          itemCount: 8, // You can adjust this number based on your components
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SizedBox(
                    height:
                        92, // Adjust height to accommodate text below circles
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: links.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemBuilder: (context, index) {

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StoryDetailsPage(
                                  storyItems: storyItemsList[index],
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              StoryCircle(
                                userNames: titles,
                                isFirst: index == 0,
                                viewedStatuses: true,
                                currentIndex: index,
                                imageUrls: links,
                              ),
                              const SizedBox(
                                  height: 4), // Space between circle and text
                              Text(
                                titles[index],
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "oswald",
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              case 1:
                return isMatchesLoading // Check loading state for matches
                    ? Center(
                        heightFactor: 2,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        )) // Show loading indicator
                    : MatchResultComponent(
                        matchResults: matchesList,
                        text: "Derniers résultats",
                        onTeamSelected: widget.onTeamSelected,
                        onMatchSelected: widget.onMatchSelected,
                      );
              case 2:
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const AdsBanner(),
                );
              case 3:
                return isVideosLoading // Check loading state for matches
                    ? Center(
                        heightFactor: 2,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        )) // Show loading indicator
                    : DynamicVideoGrid(
                        moments: moments,
                        videoPaths: videoPaths,
                        captions: captions,
                        text: "Meilleurs moments",
                      );
              case 4:
                return isAdsLoading
                    ? const Center(
                        child: CircularProgressIndicator(), // Loading icon
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: ImageSlider(
                          imagePaths: imagePaths,
                        ),
                      );

              case 5:
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start, // Aligns items to the start (left)
                        children: [
                          Text(
                            "Streaming",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: "oswald",
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 4.0,
                                  color: AppColors.textShadow,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Container(
                        width: "Streaming".length *
                            11.5, // Adjust the width for the underline
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.textShadow,
                              spreadRadius: 0,
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              case 6:
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: VideoComponent(),
                );
              case 7:
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: NewsSection(
                    onNewsSelected: widget.onNewsSelected,
                    newsList: newsList,
                    isLoading: isLoading,
                  ),
                );
              // You can add more cases here for additional widgets
              default:
                return SizedBox(); // Return an empty box for unhandled cases
            }
          },
        ),
      ),
    );
  }
}
