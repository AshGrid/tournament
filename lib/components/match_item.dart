import 'package:flutter/material.dart';
import '../models/match.dart';
import '../components/colors.dart';

class MatchItem extends StatelessWidget {
  final Match match;

  const MatchItem({Key? key, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.matchCard, // Set your background color here
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white, // Adjust border color as needed
            width: 2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Date Section
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1), // Light overlay to distinguish the date section
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    match.matchTime, // Use your date format
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Line Separator
            Container(
              width: 1, // Width of the line
              height: 60, // Adjust the height as needed
              color: Colors.white, // Color of the line
              margin: const EdgeInsets.symmetric(horizontal: 10), // Spacing around the line
            ),

            // Team Details Section
            Expanded(
              child: Column(
                children: [
                  // Home Team
                  _buildTeamRow(match.homeTeamLogo, match.homeTeam, match.homeScore),
                  SizedBox(height: 10),
                  // Away Team
                  _buildTeamRow(match.awayTeamLogo, match.awayTeam, match.awayScore),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamRow(String logoUrl, String teamName, int score) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white, // Border color of the avatar
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage(logoUrl), // Load the team logo
                  backgroundColor: Colors.transparent,
                ),
              ),
              SizedBox(width: 8),
              Text(
                teamName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            score.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
