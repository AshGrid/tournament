import 'package:flutter/material.dart';
import 'package:untitled/dep/lib/flutter_tournament_bracket.dart';

class BracketMatchCard extends StatelessWidget {
  final TournamentMatch item;

  const BracketMatchCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.teamA!),
                Text(item.scoreTeamA!),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.teamB!),
                Text(item.scoreTeamB!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}