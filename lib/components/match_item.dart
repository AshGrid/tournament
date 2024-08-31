import 'package:flutter/material.dart';
import '../models/match.dart'; // Make sure the Match class is correctly imported

class MatchItem extends StatelessWidget {
  final Match match;
  final Color backgroundColor;

  const MatchItem({Key? key, required this.match, required this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0.0), // Reduced vertical margin
      padding: const EdgeInsets.symmetric(vertical: 1.0), // Padding around the item
      color: backgroundColor,
      child: Column(

        children: [

          // Match Date at the top center
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0), // Reduced vertical padding
            child: Text(
              match.matchTime,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // First team's logo and name
              Row(
                children: [
                  Image.asset(
                    match.homeTeamLogo,
                    width: 60, // Adjust width as needed
                    height: 60, // Adjust height as needed
                  ),
                  const SizedBox(width: 8), // Space between logo and team name
                  Text(
                    match.homeTeam,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              // 'VS' text in the center
              const Text(
                'VS',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              // Second team's name and logo
              Row(
                children: [
                  Text(
                    match.awayTeam,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8), // Space between team name and logo
                  Image.asset(
                    match.awayTeamLogo,
                    width: 60, // Adjust width as needed
                    height: 60, // Adjust height as needed
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
