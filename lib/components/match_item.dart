import 'package:flutter/material.dart';
import '../models/match.dart';
import 'colors.dart'; // Ensure the Match class is correctly imported

class MatchItem extends StatelessWidget {
  final Match match;
  final Color backgroundColor;
  final bool isLastItem;
  final bool isFirstItem;

  const MatchItem({
    Key? key,
    required this.match,
    required this.backgroundColor,
    this.isLastItem = false,  this.isFirstItem = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: isLastItem ? BorderSide(color: Color(0xFFFFFFFF), width: 2) : const BorderSide(color: Color(0xFFFFFFFF), width: 1),
          top:    isFirstItem ? BorderSide(color: Color(0xFFFFFFFF), width: 2) : const BorderSide(color: Color(0xFFFFFFFF), width: 2),

        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Match time on the left
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "15-10-2024", // Use match.matchTime if it's dynamic
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white,fontFamily: 'Oswald'),
            ),
          ),
          // Vertical line
          Container(
            width: 1,
            height: 40, // Adjust the height of the divider line
            color: AppColors.timeLogoSeperator,
          ),
          // Team 1 - Team 2 logos and names
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTeamLogo(match.homeTeamLogo, match.homeTeam.name),
                const SizedBox(width: 10),
                const Text(
                  '-',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(width: 10),
                _buildTeamLogo(match.awayTeamLogo, match.awayTeam.name),
              ],
            ),
          ),
          // Vertical line
          Container(
            width: 1,
            height: 40, // Adjust the height of the divider line
            color: AppColors.timeLogoSeperator,
          ),
          // Match time on the right
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              match.matchTime,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build the team logo with rounded corners, shadow, and team name
  Widget _buildTeamLogo(String logoPath, String teamName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(

          width: 60,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: AppColors.teamLogoBorder, width: 1),
            boxShadow: [
              BoxShadow(
                color: AppColors.teamLogoShadow,
                offset: const Offset(2, 2), // Shadow direction and offset
                blurRadius: 4, // Amount of blur for the shadow
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              logoPath,
              fit: BoxFit.scaleDown,
              width: 55,
              height: 40,
            ),
          ),
        ),
        const SizedBox(height: 4), // Space between logo and team name
        Text(
          teamName,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
