import 'package:flutter/material.dart';

class AdsBanner extends StatelessWidget {
  const AdsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08, // Adjust the height as needed
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.grey[50], // Background color for the ad banner
        borderRadius: BorderRadius.circular(20.0), // Radius for rounded corners
        border: Border.all(
          color: Colors.black12, // Border color
          width: 1.0, // Border width
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/icons/logo.png', // Path to the logo image
              height: 50.0, // Adjust the height of the logo
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Your Ad Here', // Replace with actual ad text or leave empty
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
