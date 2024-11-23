import 'package:flutter/material.dart';
import '../components/colors.dart';

class MenuScreen extends StatefulWidget {
  final Function() onNewsTapped;
  final Function() onStreamTapped;
  final Function() onMomentsTapped;

  MenuScreen({
    required this.onNewsTapped,
    required this.onStreamTapped,
    required this.onMomentsTapped,
  });

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: AppColors.backgroundColor, // Use the gradient here
        ),
        child: Center( // Center the content vertically and horizontally
          child: Padding(
            padding: const EdgeInsets.only(left: 0,right: 0,top: 50,bottom: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Center the column contents
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildMenuItem(
                  context,
                  iconPath: 'assets/images/moments.png', // Replace with actual image path
                  text: "Meilleurs moments",
                  onTap: widget.onMomentsTapped,
                ),
                const SizedBox(height: 16),
                _buildMenuItem(
                  context,
                  iconPath: 'assets/images/streaming.png', // Replace with actual image path
                  text: "Streaming",
                  onTap: widget.onStreamTapped,
                ),
                const SizedBox(height: 16),
                _buildMenuItem(
                  context,
                  iconPath: 'assets/images/news.png', // Replace with actual image path
                  text: "News",
                  onTap: widget.onNewsTapped,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {required String iconPath, required String text, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: const BorderSide(color: Color(0xFFFFFFFF), width: 2),
            top: const BorderSide(color: Color(0xFFFFFFFF), width: 2),
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
          // leading: Container(
          //   width: 55,
          //   height: 55,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(15.0),
          //     border: Border.all(
          //       color: AppColors.bottomSheetLogo,
          //       width: 1.0,
          //     ),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.black.withOpacity(0.25),
          //         blurRadius: 4.0,
          //         spreadRadius: 0.0,
          //         offset: const Offset(0, 4),
          //       ),
          //     ],
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(2.0),
          //     child: Image.asset(
          //       iconPath,
          //       fit: BoxFit.scaleDown,
          //     ),
          //   ),
          // ),
          title: Text(
            textAlign: TextAlign.center,
            text.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "oswald",
              shadows: [
                Shadow(
                  blurRadius: 4.0,
                  color: AppColors.textShadow,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
