import 'package:flutter/material.dart';
import 'package:untitled/components/colors.dart';
import '../components/ads_banner.dart';
import '../components/story_circle.dart';
import 'bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetContent();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),
                const AdsBanner(),
                 // Add the AdsBanner widget
              ],
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: IconButton(
              icon: ImageIcon(AssetImage("assets/icons/lines.png")),
              onPressed: () {
                _showBottomSheet(context);
              },
              tooltip: 'Open Bottom Sheet',
            ),
          ),
        ],
      ),
    );
  }
}
