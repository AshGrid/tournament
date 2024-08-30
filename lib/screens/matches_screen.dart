import 'package:flutter/material.dart';
import '../models/match.dart';
import '../components/match_item.dart';

class MatchesScreen extends StatelessWidget {
  final Function(Match) onMatchTap; // Callback function to handle match selection

  const MatchesScreen({super.key, required this.onMatchTap});

  @override
  Widget build(BuildContext context) {
    final matches = [
      Match(homeTeam: 'Team A', awayTeam: 'Team B', homeScore: 1, awayScore: 0, matchTime: '45\'', matchStatus: 'live',homeTeamLogo: 'assets/images/itachi.jpg',awayTeamLogo: 'assets/icons/field.png'),
      Match(homeTeam: 'Team A', awayTeam: 'Team B', homeScore: 1, awayScore: 0, matchTime: '45\'', matchStatus: 'live',homeTeamLogo: 'assets/icons/lines.png',awayTeamLogo: 'assets/icons/lines.png'),
      Match(homeTeam: 'Team A', awayTeam: 'Team B', homeScore: 1, awayScore: 0, matchTime: '45\'', matchStatus: 'live',homeTeamLogo: 'assets/icons/lines.png',awayTeamLogo: 'assets/icons/lines.png'),
      Match(homeTeam: 'Team A', awayTeam: 'Team B', homeScore: 1, awayScore: 0, matchTime: '45\'', matchStatus: 'live',homeTeamLogo: 'assets/icons/lines.png',awayTeamLogo: 'assets/icons/lines.png'),
      Match(homeTeam: 'Team A', awayTeam: 'Team B', homeScore: 1, awayScore: 0, matchTime: '45\'', matchStatus: 'live',homeTeamLogo: 'assets/icons/lines.png',awayTeamLogo: 'assets/icons/lines.png'),
      Match(homeTeam: 'Team A', awayTeam: 'Team B', homeScore: 1, awayScore: 0, matchTime: '45\'', matchStatus: 'live',homeTeamLogo: 'assets/icons/lines.png',awayTeamLogo: 'assets/icons/lines.png'),
      Match(homeTeam: 'Team A', awayTeam: 'Team B', homeScore: 1, awayScore: 0, matchTime: '45\'', matchStatus: 'live',homeTeamLogo: 'assets/icons/lines.png',awayTeamLogo: 'assets/icons/lines.png'),
      Match(homeTeam: 'Team A', awayTeam: 'Team B', homeScore: 1, awayScore: 0, matchTime: '45\'', matchStatus: 'live',homeTeamLogo: 'assets/icons/lines.png',awayTeamLogo: 'assets/icons/lines.png'),
      Match(homeTeam: 'Team A', awayTeam: 'Team B', homeScore: 1, awayScore: 0, matchTime: '45\'', matchStatus: 'live',homeTeamLogo: 'assets/icons/lines.png',awayTeamLogo: 'assets/icons/lines.png'),

    ];

    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onMatchTap(matches[index]), // Invoke the callback with the selected match
          child: MatchItem(match: matches[index]),
        );
      },
    );
  }
}
