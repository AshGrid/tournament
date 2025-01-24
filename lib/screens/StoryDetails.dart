import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import '../components/colors.dart';
import 'StoryViewScreen.dart';

class StoryDetailScreen extends StatefulWidget {
  final List<List<String>> allStories; // All stories as a list of media (image/video) sets
  final List<String> userNames; // Corresponding usernames
  final int initialIndex; // Index of the first story set to display
  final StoryController _storyController = StoryController();

  StoryDetailScreen({
    Key? key,
    required this.allStories,
    required this.userNames,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  _StoryDetailScreenState createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  final StoryController _storyController = StoryController();

  @override
  Widget build(BuildContext context) {
    final List<StoryItem> storyItems = widget.allStories[widget.initialIndex]
        .map((mediaUrl) {
      if (isVideo(mediaUrl)) {
        // If it's a video, use the pageVideo constructor
        return StoryItem.pageVideo(
          mediaUrl,
          controller: _storyController,
          caption: Text(widget.userNames[widget.initialIndex]),
          duration: Duration(seconds: 30),
        );
      } else {
        // If it's an image, use the pageImage constructor
        return StoryItem.pageImage(
          url: mediaUrl,
          controller: _storyController,
          caption: Text(widget.userNames[widget.initialIndex]),
        );
      }
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.navbarColor,
      body: StoryViewScreen(
        storyItems: storyItems,
        controller: widget._storyController, onComplete: () {  },
      ),
    );
  }

  @override
  void dispose() {
    _storyController.dispose(); // Dispose the controller when not needed
    super.dispose();
  }

  // Helper function to determine if a URL points to a video
  bool isVideo(String url) {
    return url.endsWith(".mp4") || url.endsWith(".mov") || url.endsWith(".avi") || url.endsWith(".mkv");
  }
}
