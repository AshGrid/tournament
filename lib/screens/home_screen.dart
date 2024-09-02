import 'package:flutter/material.dart';
import '../components/colors.dart'; // Import the colors file
import '../components/story_circle.dart';
import 'bottom_sheet.dart';
import '../components/full_story_screen.dart'; // Import FullStoryScreen
import '../components/image_slider.dart'; // Import the ImageSlider widget
import '../components/video_component.dart'; // Import the VideoComponent widget
import '../components/match_result_component.dart'; // Import MatchResultComponent widget
import '../components/ads_banner.dart'; // Import AdsBanner widget
import '../components/dynamic_image_grid.dart';
import '../components/news_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetContent();
      },
    );
  }

  void _openFullStory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FullStoryScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<MatchResult> matchResults = [
      MatchResult(
        team1Logo: 'assets/icons/dots.png',
        team2Logo: 'assets/icons/dots.png',
        result: '2 - 1',
        dateTime: '2024-08-30 20:00',
        stadiumName: 'Stadium Name',
      ),
      MatchResult(
        team1Logo: 'assets/icons/dots.png',
        team2Logo: 'assets/icons/dots.png',
        result: '1 - 3',
        dateTime: '2024-08-31 18:00',
        stadiumName: 'Another Stadium',
      ),
      MatchResult(
        team1Logo: 'assets/icons/dots.png',
        team2Logo: 'assets/icons/dots.png',
        result: '1 - 1',
        dateTime: '2024-08-31 18:00',
        stadiumName: 'Another Stadium',
      ),
      // Add more MatchResult objects as needed
    ];

    final List<NewsItem> newsItems = [
      NewsItem(title: 'Breaking News 1'),
      NewsItem(title: 'Breaking News 2'),
      NewsItem(title: 'Breaking News 3'),
      // Add more NewsItem objects as needed
    ];

    final List<String> imagePaths = [
      'assets/images/ahri.jpg',
      'assets/images/itachi.jpg',
      'assets/images/jabami.jpg',
      'assets/images/sample.jpg', // Add more paths as needed
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundColor, // Use the gradient here
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      _openFullStory(context); // Open full-screen story on tap
                    },
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: StoryCircle(
                        imageUrls: [
                          'assets/images/ahri.jpg',
                          'assets/images/itachi.jpg',
                          'assets/images/jabami.jpg',
                        ],
                        userName: 'User 1',
                      ),
                    ),
                  ),
                ),
              ),
              // Use the ImageSlider widget here
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ImageSlider(
                  imagePaths: [
                    'assets/images/ahri.jpg',
                    'assets/images/itachi.jpg',
                    'assets/images/jabami.jpg',
                  ],
                ),
              ),
              // Add the VideoComponent widget here
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: VideoComponent(
                  videoUrl: 'assets/videos/cs2.mp4', // Provide the path to your video
                  title: 'Video Title',
                  description: '',
                ),
              ),
              // Add the MatchResultComponent widget here
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MatchResultComponent(
                  matchResults: matchResults,
                ),
              ),
              // Add the smaller AdsBanner widget here
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust horizontal padding
                child: const AdsBanner(), // Adds the ad banner with padding to the layout
              ),
              // Add the DynamicImageGrid widget here
              DynamicImageGrid(
                imagePaths: imagePaths,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: NewsSection(newsItems: newsItems),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
