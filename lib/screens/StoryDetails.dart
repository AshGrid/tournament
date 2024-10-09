import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import '../components/colors.dart';


class StoryDetailScreen extends StatefulWidget {
  final List<List<String>> allStories; // All stories as a list of image sets
  final List<String> userNames; // Corresponding usernames
  final int initialIndex; // Index of the first story set to display

  const StoryDetailScreen({
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
        .map(
          (imageUrl) => StoryItem.pageImage(
        url: imageUrl,
        controller: _storyController,
        caption: Text(widget.userNames[widget.initialIndex]),
      ),
    )
        .toList();

    return Scaffold(
      backgroundColor: AppColors.navbarColor,
      body: StoryView(
        storyItems: storyItems,
        controller: _storyController,
        repeat: false, // Set to false if you don't want it to loop
        onComplete: () {
          Navigator.pop(context); // Close the story when complete
        },
      ),
    );
  }

  @override
  void dispose() {
    _storyController.dispose(); // Dispose the controller when not needed
    super.dispose();
  }
}
