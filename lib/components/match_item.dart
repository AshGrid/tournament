import 'package:flutter/material.dart';
import '../models/match.dart'; // Make sure to import the Match model

class MatchItem extends StatelessWidget {
  final Match match;

  const MatchItem({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(match.score)),
        title: Text('${match.team1} vs ${match.team2}'),
        subtitle: Text(match.time),
      ),
    );
  }
}
