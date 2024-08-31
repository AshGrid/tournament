import 'package:flutter/material.dart';
import 'package:untitled/components/colors.dart'; // Ensure AppColors is imported
import '../models/match.dart';

class MatchDetailsPage extends StatelessWidget {
  final Match match;

  const MatchDetailsPage({Key? key, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match Details'),
        backgroundColor: Colors.blueAccent, // AppBar color
        foregroundColor: Colors.white, // AppBar text color
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundColor, // Use predefined gradient
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding around the container
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
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
              mainAxisSize: MainAxisSize.min,
              children: [
                // Date and Time
                Text(
                  match.matchTime,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                SizedBox(height: 8),

                // Match Status
                Center(
                  child: Text(
                    match.matchStatus,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10),

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
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.grey.shade200,
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
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          Text(
                            match.matchTime,
                            style: TextStyle(fontSize: 16, color: Colors.black54),
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
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.grey.shade200,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
