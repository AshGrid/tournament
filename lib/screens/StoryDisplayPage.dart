import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoryDisplayPage extends StatefulWidget {
  final List<StoryItem> storyItems; // List of story items to display

  const StoryDisplayPage({Key? key, required this.storyItems}) : super(key: key);

  @override
  _StoryDisplayPageState createState() => _StoryDisplayPageState();
}

class _StoryDisplayPageState extends State<StoryDisplayPage> {
  late StoryController _storyController;

  @override
  void initState() {
    super.initState();
    _storyController = StoryController(); // Initialize the story controller
  }

  @override
  void dispose() {
    _storyController.dispose(); // Dispose of the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Black background for story view
      body: SafeArea(
        child: StoryView(
          storyItems: widget.storyItems, // The list of stories to display
          controller: _storyController, // Story controller
          onComplete: () {
            Navigator.pop(context); // Navigate back when stories are completed
          },
          inline: false, // Fullscreen view
          repeat: false, // Disable repeating of stories
        ),
      ),
    );
  }
}