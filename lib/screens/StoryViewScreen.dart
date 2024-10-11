
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
class StoryViewScreen extends StatelessWidget {
  final List<StoryItem> storyItems;
  final StoryController controller;

  StoryViewScreen({required this.storyItems, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryView(
        storyItems: storyItems,
        onStoryShow: (storyItem, index) {
          print("Showing a story");
        },
        onComplete: () {
          print("Completed a cycle");
        },
        progressPosition: ProgressPosition.bottom,
        repeat: false,
        controller: controller,
      ),
    );
  }
}