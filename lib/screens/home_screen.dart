import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:untitled/models/match.dart';
import 'package:untitled/screens/Story.dart';
import '../components/colors.dart'; // Import the colors file
import '../components/story_circle.dart';
import '../models/news.dart';
import 'bottom_sheet.dart';
import '../components/full_story_screen.dart'; // Import FullStoryScreen
import '../components/image_slider.dart'; // Import the ImageSlider widget
import '../components/video_component.dart'; // Import the VideoComponent widget
import '../components/match_result_component.dart'; // Import MatchResultComponent widget
import '../components/ads_banner.dart'; // Import AdsBanner widget
import '../components/dynamic_image_grid.dart';
import '../components/news_section.dart';

class HomeScreen extends StatefulWidget {
  final Function(NewsItem) onNewsSelected;

  const HomeScreen({Key? key, required this.onNewsSelected}) : super(key: key);


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  List<StoryItem> storyitems = [];
  // Initialize viewedStatuses for each story



  final List<bool> viewedStatuses = [
    true,  // Story set 1 has been viewed
    false, // Story set 2 has not been viewed
    true,  // Story set 3 has been viewed
    true,
    true,
    // Add more statuses as needed
  ];

  // Function to open the full story screen
  void _openFullStory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>  Story(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // List of MatchResult objects
    final List<MatchResult> matchResults = [
      MatchResult(
        team1Logo: 'assets/images/ennakl.jpg',
        team2Logo: 'assets/images/monoprix.jpg',
        result: '2 - 1',
        dateTime: '2024-08-30 20:00',
        stadiumName: 'Five stars club', team1Name: 'ennakl', team2Name: 'monoprix',
      ),
      MatchResult(
        team1Logo: 'assets/images/ennakl.jpg',
        team2Logo: 'assets/images/monoprix.jpg',
        result: '1 - 3',
        dateTime: '2024-08-31 18:00',
        stadiumName: 'Five stars club', team1Name: 'ennakl', team2Name: 'monoprix',
      ),
      MatchResult(
        team1Logo: 'assets/images/ennakl.jpg',
        team2Logo: 'assets/images/monoprix.jpg',
        result: '1 - 1',
        dateTime: '2024-08-31 18:00',
        stadiumName: 'Five stars club', team1Name: 'ennakl', team2Name: 'monoprix',
      ),
      // Add more MatchResult objects as needed
    ];

    // List of NewsItem objects
    final List<NewsItem> newsItems = [
      NewsItem(title: 'TITRE DE NEWS 1',imageUrl: 'assets/images/monoprix.jpg',content: "ojwojdwojdowjdowjdowj",date: DateTime(2024, 10, 6),),
      NewsItem(title: 'TITRE DE NEWS 2',imageUrl: 'assets/images/monoprix.jpg',content: "ojwojdwojdowjdowjdowj",date: DateTime(2024, 10, 6),),
      NewsItem(title: 'TITRE DE NEWS 3',imageUrl: 'assets/images/monoprix.jpg',content: "ojwojdwojdowjdowjdowj",date: DateTime(2024, 10, 6),),
    ];

    List<String> imagePath = [
      'assets/images/image1.jpeg',
      'assets/images/image2.jpeg',
      'assets/images/image1.jpeg',
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundColor, // Use the gradient here
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Horizontal scrollable list of StoryCircle widgets with text below
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                child: SizedBox(
                  height: 92, // Adjust height to accommodate text below circles
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: imagePaths.length, // Use the length of the outer list
                    separatorBuilder: (context, index) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final images = imagePaths[index]; // Access the list of images for each story
                      return GestureDetector(
                        onTap: () {
                          _openFullStory(context); // Open full-screen story on tap
                        },
                        child: Column(
                          children: [
                            StoryCircle(
                              imageUrls: imagePaths, // Pass the list of images to the StoryCircle
                              userNames: users, // Example user names
                              isFirst: index == 0, // Set isFirst to true for the first circle
                              viewedStatuses: viewedStatuses, // Pass the viewed statuses
                              currentIndex: index,
                            ),
                            const SizedBox(height: 4), // Space between circle and text
                            Text(
                              users[index], // Example text below each story circle
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                fontFamily: "oswald",
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis, // Prevent text overflow
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Use the MatchResultComponent widget here
              MatchResultComponent(
                matchResults: matchResults,
                text: "Dernier résultat",
              ),
              // Adds the ad banner with padding to the layout
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: const AdsBanner(),
              ),
              // Dynamic Image Grid
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.8),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height*0.9 ,
                  child: DynamicImageGrid(
                    imagePaths: imagePath,
                    captions: ['Caption 1', 'Caption 2', 'Caption 3'],
                    text: "Meilleurs moments",
                  ),
                ),
              ),
              // Add the ImageSlider widget
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: ImageSlider(
                  imagePaths: imagePath,
                ),
              ),
              // Add the VideoComponent widget
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: VideoComponent(
                  videoUrl: 'assets/videos/videofoot.mp4', // Provide the path to your video
                  title: 'Streaming',
                  description: '',
                ),
              ),
              // Add the NewsSection widget
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: NewsSection(newsItems: newsItems, onNewsSelected:  widget.onNewsSelected,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


