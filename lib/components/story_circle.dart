import 'package:flutter/material.dart';

import 'story_details.dart';

class StoryCircle extends StatelessWidget {
  final List<String> imageUrls;
  final String userName;

  const StoryCircle({
    Key? key,
    required this.imageUrls,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StoryDetailScreen(
              imageUrls: imageUrls,
              userName: userName,
            ),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.red, width: 1),
            ),
            child: CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(imageUrls[0]), // Show first image as thumbnail
            ),
          ),

        ],
      ),
    );
  }
}
