// player_info.dart
import 'package:flutter/material.dart';


class playerCardAway extends StatelessWidget {
  final String playerName;
 // final String playerPosition;
  final String playerImage; // Image path or URL

  const playerCardAway({
    Key? key,
    required this.playerName,
    //required this.playerPosition,
    required this.playerImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      decoration: BoxDecoration(
        color: Colors.transparent, // Adjust background color



      ),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Player Image



          // Player Name and Position
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                playerName,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Adjust text color
                ),
              ),
              SizedBox(height: 4.0), // Space between name and position
              // Text(
              //   playerPosition,
              //   style: TextStyle(
              //     fontSize: 10.0,
              //     color: Colors.grey, // Lighter color for position
              //   ),
              // ),
            ],
          ),
          SizedBox(width: 5.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.grey,width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0), // Circular image
              child: Image.asset(
                playerImage, // Ensure the image path is valid
                width: 50.0,  // Set image size
                height: 50.0,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
