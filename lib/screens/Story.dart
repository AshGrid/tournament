import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoryDetailsPage extends StatefulWidget {
  final List<StoryItem> storyItems;

  const StoryDetailsPage({Key? key, required this.storyItems}) : super(key: key);

  @override
  _StoryDetailsPageState createState() => _StoryDetailsPageState();
}

class _StoryDetailsPageState extends State<StoryDetailsPage> {
  late StoryController _storyController;

  @override
  void initState() {
    super.initState();
    _storyController = StoryController();
  }

  @override
  void dispose() {
    _storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StoryView(
        storyItems: widget.storyItems, // Use the passed stories
        controller: _storyController, // Pass StoryController
        onComplete: () {
          Navigator.pop(context); // Close the story viewer when completed
        },
        onVerticalSwipeComplete: (direction) {
          if (direction == Direction.down) {
            Navigator.pop(context); // Allow swipe down to close
          }
        },
      ),
    );
  }
}
