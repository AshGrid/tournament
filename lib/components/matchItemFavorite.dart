import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Match.dart';
import 'colors.dart'; // Ensure the Match class is correctly imported

class MatchItemFavorite extends StatelessWidget {
  final Match match;
  final Color backgroundColor;
  final bool isLastItem;

  const MatchItemFavorite({
    Key? key,
    required this.match,
    required this.backgroundColor,
    this.isLastItem = false,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(color: Color(0xFFFFFFFF), width: 2),
        ),
      ),
      child: Row(
        children: [
          // Favorite icon on the left
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: const Icon(Icons.star, color: AppColors.favoriteIcon),
              onPressed: () {
                // Handle favorite icon press action here
              },
            ),
          ),

          // Conditional vertical line
          Container(
            width: 1,
            height: 70, // Adjust the height of the divider line
            color: AppColors.timeLogoSeperator,
          ),

          const SizedBox(width: 7),
          Expanded(
            child: Row(
              children: [
                // Teams column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    // Team 1 logo and name
                    _buildTeamLogo("${match.home!.logo}", match.home!.name),
                    const SizedBox(height: 8), // Space between team 1 and team 2
                    // Team 2 logo and name
                    _buildTeamLogo("${match.away!.logo}", match.away!.name),
                  ],
                ),
                const Spacer(),
Text(
  "${ DateFormat('MMMM d, yyyy').format(match.date!)}",
  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.white),),
                // Score on the far right
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    width: 60, // Width of the container
                    height: 80, // Height of the container
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.transparent, width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${match.home_first_half_score!+match.home_second_half_score!}", // Home team score
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const Text(
                          "",
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          "${match.away_first_half_score!+match.away_second_half_score!}", // Away team score
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build the team logo with rounded corners, shadow, and team name
  Widget _buildTeamLogo(String logoPath, String teamName) {
    return Row(
      children: [
        Container(
          width: 50, // Adjusted width
          height: 35, // Adjusted height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: AppColors.teamLogoBorder, width: 1),
            boxShadow: const [
              BoxShadow(
                color: AppColors.teamLogoShadow,
                offset: Offset(2, 2), // Shadow direction and offset
                blurRadius: 4, // Amount of blur for the shadow
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: Image.network(
              logoPath,
              fit: BoxFit.scaleDown,
              width: 50,
              height: 35,
            ),
          ),
        ),
        const SizedBox(width: 8), // Space between logo and team name
        Text(
          teamName,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }
}
