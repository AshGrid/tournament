import 'package:flutter/material.dart';
import 'package:untitled/screens/StreamingScreen.dart';
import '../components/colors.dart';

class MenuScreen extends StatefulWidget {
  final Function() onNewsTapped;
  final Function() onStreamTapped;
  final Function() onMomentsTapped;

  MenuScreen({required this.onNewsTapped, required this.onStreamTapped, required this.onMomentsTapped});

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPressableText(context, "Meilleurs moments"),
              const SizedBox(height: 8), // Space between text and line
              _buildDivider("Meilleurs moments"),
              _buildPressableText(context, "Streaming"),
              const SizedBox(height: 8), // Space between text and line
              _buildDivider("Streaming"),
              _buildPressableText(context, "News"),
              const SizedBox(height: 8), // Space between text and line
              _buildDivider("News"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPressableText(BuildContext context, String text) {
    return GestureDetector(
      onTap: () {
        if (text == "News") {
          widget.onNewsTapped(); // Accessing the parent callback
        }
        if (text == "Streaming") {
          widget.onStreamTapped();// Accessing the parent callback
        }
        if (text == "Meilleurs moments") {
          widget.onMomentsTapped();// Accessing the parent callback
        }
        // Handle the text press event here

      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDivider(String text) {
    return Container(
      width: text.length * 10.0, // Adjust width based on text length
      height: 3,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.textShadow,
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
    );
  }
}
