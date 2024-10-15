import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:untitled/Service/mock_data.dart';
import 'package:untitled/models/Match.dart';
import 'package:untitled/screens/Story.dart';
import '../Service/data_service.dart';
import '../components/colors.dart'; // Import the colors file
import '../components/story_circle.dart';
import '../models/News.dart';
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
  HomeScreen({Key? key, required this.onNewsSelected}) : super(key: key);

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
  @override
  void initState() {
    super.initState();
    _fetchNews();
    _fetchMatches();
    _fetchStream();
  }

  Future<void> _fetchStream() async {
    final streamItem = await dataService.fetchStream();
    setState(() {
      streamItems = streamItem;
    });
  }

  Future<void> _fetchNews() async {
    try {
      final fetchedNews = await dataService.fetchNews();
      setState(() {
        newsList = fetchedNews;
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

  Future<void> _fetchMatches() async {
    try {
      final fetchedMatches = await dataService.fetchPlayedMatches();
      setState(() {
        matchesList = fetchedMatches;
        isMatchesLoading = false; // Set loading to false after fetching matches
      });
    } catch (e) {
print("error fetching matches for result component$e");
setState(() {
        isMatchesLoading = false; // Stop loading on error
      });
    }
  }

  // List of image paths
  List<List<String>> imagePaths = [
    [
      'assets/images/image1.jpeg',
      'assets/images/image2.jpeg',
      'assets/images/image1.jpeg',
    ],
    [
      'assets/images/ABC.png',
      'assets/images/image2.jpeg',
      'assets/images/image1.jpeg',
    ],
    [
      'assets/images/image1.jpeg',
      'assets/images/image2.jpeg',
      'assets/images/image1.jpeg',
    ],
    [
      'assets/images/image1.jpeg',
      'assets/images/image2.jpeg',
      'assets/images/image1.jpeg',
    ],
    [
      'assets/images/image1.jpeg',
      'assets/images/image2.jpeg',
      'assets/images/image1.jpeg',
    ],
  ];

  List<String> users = [
    'A l’instant',
    'TOP ARRETS',
    'DANS LES FILETS',
    'VU DU BANC',
    'AMBIANCE',
  ];

  final List<List<Map<String, String>>> allStories = [
    [
      {'type': 'image', 'url': 'assets/images/image1.jpeg'},
      {'type': 'video', 'url': 'assets/videos/videofoot.mp4'},
      {'type': 'image', 'url': 'assets/images/image2.jpeg'},
    ],
    [
      {'type': 'image', 'url': 'assets/images/image3.jpg'},
      {'type': 'video', 'url': 'assets/videos/videofoot.mp4'},
    ],
    [
      {'type': 'image', 'url': 'assets/images/image3.jpg'},
      {'type': 'video', 'url': 'assets/videos/videofoot.mp4'},
    ],
    [
      {'type': 'image', 'url': 'assets/image3.jpg'},
      {'type': 'video', 'url': 'https://your-video-url.com/video2.mp4'},
    ],
    [
      {'type': 'image', 'url': 'assets/image3.jpg'},
      {'type': 'video', 'url': 'https://your-video-url.com/video2.mp4'},
    ],
  ];

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

  // Function to open the full story screen
  void _openFullStory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryViewScreen(
          storyItems: [
            StoryItem.text(
              title:
                  "Hello world!\nHave a look at some great Ghanaian delicacies. I'm sorry if your mouth waters. \n\nTap!",
              backgroundColor: Colors.orange,
              roundedTop: true,
            ),
            StoryItem.inlineImage(
              url:
                  "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
              controller: widget._storyController,
              caption: Text(
                "Omotuo & Nkatekwan; You will love this meal if taken as supper.",
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: Colors.black54,
                  fontSize: 17,
                ),
              ),
            ),
            StoryItem.inlineImage(
              url: "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
              controller: widget._storyController,
              caption: Text(
                "Hektas, sektas and skatad",
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: Colors.black54,
                  fontSize: 17,
                ),
              ),
            ),
          ],
          controller: widget._storyController,
        ),
      ),
    );
  }

  List<String> imagePath = [
    'assets/images/image1.jpeg',
    'assets/images/image2.jpeg',
    'assets/images/image1.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
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
                      itemCount: imagePaths.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final images = imagePaths[
                            index]; // Access the list of images for each story
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
                                userNames: users,
                                isFirst: index == 0,
                                viewedStatuses: viewedStatuses,
                                currentIndex: index,
                                imageUrls: imagePaths,
                              ),
                              const SizedBox(
                                  height: 4), // Space between circle and text
                              Text(
                                users[index],
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
                      );
              case 2:
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const AdsBanner(),
                );
              case 3:
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.8),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: DynamicImageGrid(
                      imagePaths: imagePath,
                      captions: ['Caption 1', 'Caption 2', 'Caption 3'],
                      text: "Meilleurs moments",
                    ),
                  ),
                );
              case 4:
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: ImageSlider(
                    imagePaths: imagePath,
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
