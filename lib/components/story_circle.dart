import 'package:flutter/material.dart';
import 'colors.dart';
import 'story_details.dart';

class StoryCircle extends StatelessWidget {
  final List<List<String>> imageUrls;
  final List<String> userNames;
  final bool viewedStatuses; // New list to check if stories have been viewed
  final bool isFirst;
  final int currentIndex;

  const StoryCircle({
    Key? key,
    required this.imageUrls,
    required this.userNames,
    required this.viewedStatuses, // Add this
    this.isFirst = false,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isViewed = viewedStatuses; // Check if current story is viewed

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StoryDetailScreen(
              allStories: imageUrls,
              userNames: userNames,
              initialIndex: currentIndex,
            ),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 36,
            backgroundImage: AssetImage(
              isFirst
                  ? 'assets/images/ABC.png'
                  : imageUrls[currentIndex].first,
            ),
          ),
          CustomPaint(
            size: Size(72, 72),
            painter: GradientBorderPainter(isViewed: isViewed), // Pass viewed status
          ),
        ],
      ),
    );
  }
}

class GradientBorderPainter extends CustomPainter {
  final bool isViewed;

  GradientBorderPainter({required this.isViewed});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..shader = LinearGradient(
        colors: isViewed
            ? [AppColors.storyBorderViewed1, AppColors.storyBorderViewed2, AppColors.storyBorderViewed3] // Three colors for viewed stories
            : [AppColors.storyBorderNotViewed1, AppColors.storyBorderNotViewed2, AppColors.storyBorderNotViewed3], // Three colors for not viewed stories
        stops: [0.0, 0.5, 1.0], // Adjust these stops as needed
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final radius = size.width / 2;
    final center = Offset(radius, radius);

    canvas.drawCircle(center, radius - paint.strokeWidth / 2, paint);
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

