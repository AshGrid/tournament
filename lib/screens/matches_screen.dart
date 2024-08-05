import 'package:flutter/material.dart';
import 'package:untitled/components/colors.dart';
import '../models/match.dart'; // Import the Match model
import '../components/match_item.dart'; // Import the MatchItem widget

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    final matches = [
      Match(team1: 'Team A', team2: 'Team B', score: '1-0', time: '45\''),
      Match(team1: 'Team C', team2: 'Team D', score: '2-2', time: '90\''),
      Match(team1: 'Team E', team2: 'Team F', score: '0-1', time: '60\''),
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Ongoing Matches'),
        backgroundColor: AppColors.navbarColor,
      ),
      body: ListView.builder(

        itemCount: matches.length,
        itemBuilder: (context, index) {

          return MatchItem(match: matches[index]);
        },
      ),
    );
  }
}
