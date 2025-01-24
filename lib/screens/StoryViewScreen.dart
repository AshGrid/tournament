
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:video_player/video_player.dart';
class StoryViewScreen extends StatelessWidget {
  final List<StoryItem> storyItems;
  final StoryController controller;
final void Function()? onComplete;
  StoryViewScreen({required this.storyItems, required this.controller,required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryView(
        storyItems: storyItems,
        onStoryShow: (storyItem, index) {
          print("Showing a story");
        },
        onComplete: () {
          onComplete!();
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: controller,

      ),
    );
  }
}