import 'package:flutter/material.dart';
import 'package:untitled/components/colors.dart'; // Ensure AppColors is imported
import '../models/match.dart';

class MatchDetailsPage extends StatelessWidget {
  final Match match;

  const MatchDetailsPage({Key? key, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.backgroundColor, // Use predefined gradient
            ),
          ),
          // Column to stack the two containers
          Column(
            children: [
              // First container with match details
              SizedBox(
                height: 150, // Fixed height
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Horizontal margin for spacing
                  padding: const EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6), // 40% transparent background
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blueAccent, width: 2), // Blue border
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date and Time
                      Text(
                        match.matchTime,
                        style: TextStyle(fontSize: 10, color: Colors.black54),
                        textAlign: TextAlign.center,// Adjust font size
                      ),
                      SizedBox(height: 4),

                      // Match Status
                      Center(
                        child: Text(
                          match.matchStatus,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),

                      // Teams and Scores
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Home Team
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  match.homeTeam,
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 4),
                                CircleAvatar(
                                  radius: 16,
                                  backgroundImage: AssetImage(match.homeTeamLogo), // Load the team logo
                                  backgroundColor: Colors.transparent,
                                ),
                              ],
                            ),
                          ),

                          // Scores and Time
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '${match.homeScore} - ${match.awayScore}',
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  match.matchTime,
                                  style: TextStyle(fontSize: 12, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),

                          // Away Team
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  match.awayTeam,
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 4),
                                CircleAvatar(
                                  radius: 16,
                                  backgroundImage: AssetImage(match.awayTeamLogo), // Load the team logo
                                  backgroundColor: Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Second container with additional details
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Horizontal margin for spacing
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6), // 40% transparent background
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blueAccent, width: 2), // Blue border
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Additional details like goals and cards
                        Text(
                          'Goal Times and Cards',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        // Example content
                        Text(
                          'Goal at 23\' - Player 1\nCard: Yellow - Player 2\n...',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
