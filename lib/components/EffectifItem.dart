// player_info.dart
import 'package:flutter/material.dart';
import 'package:untitled/models/player.dart';

import 'colors.dart';


class Effectifitem extends StatelessWidget {
  final Player player;
  final String playerName;
  //final String playerPosition;
  final String playerImage; // Image path or URL
  final bool isLastItem;

  const Effectifitem({
    Key? key,
    required this.playerName,
    //required this.playerPosition,
    required this.playerImage,
    this.isLastItem = false,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 4,right: 4,top: 4,bottom: 6),
      margin: const EdgeInsets.only(left: 0,right: 0,top: 4,bottom: 7.1),
      decoration: BoxDecoration(

    border: Border(
      bottom: isLastItem ? BorderSide.none : const BorderSide(color: Color(0xFFFFFFFF), width: 1),
    ),
    ),
      child: Row(
        children: [
          // Player Image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.grey,width: 1),
              boxShadow: [
                BoxShadow(
                  color: AppColors.teamLogoShadow,
                  offset: Offset(1, 10),
                  blurRadius: 20.3,
                  spreadRadius: 3
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0), // Circular image
              child: Image.asset(
                playerImage, // Ensure the image path is valid
                width: 50.0,  // Set image size
                height: 50.0,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(width: 15.0), // Add some space between image and text

          // Player Name and Position
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                playerName,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white, // Adjust text color
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
