import 'package:flutter/material.dart';

class StoryProgressBar extends StatelessWidget {
  final int totalImages; // Total number of images in the current story
  final double progress; // Overall progress for the story
  final int imageDuration; // Duration each image is displayed (in seconds)

  const StoryProgressBar({
    Key? key,
    required this.totalImages,
    required this.progress,
    required this.imageDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5, // Height of the progress bar
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.5),
          color: Colors.grey.withOpacity(0.5), // Background color for the progress bar
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: MediaQuery.of(context).size.width * progress,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.5),
              color: Colors.blue, // Fill color for the progress
            ),
          ),
        ),
      ),
    );
  }
}
