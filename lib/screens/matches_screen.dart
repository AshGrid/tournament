import 'package:flutter/material.dart';
import '../components/LeagueComponent.dart';
import '../models/league.dart'; // Import your League model
import '../models/match.dart'; // Import your Match model
// Import the LeagueComponent

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample list of days to display
    List<String> days = [
      'Journée 1',
      'Journée 2',
      'Journée 3',
      'Journée 4',
      'Journée 5',
      'Journée 6',
      'Journée 7',
    ];

    // Sample list of leagues
    List<League> leagues = [
      League(
        leagueName: 'League A',
        matches: [
          Match(homeTeam: 'teram A', awayTeam: 'team B', homeScore: 1, awayScore: 2, matchStatus: 'live', matchTime: '19:48', homeTeamLogo: 'assets/images/itachi.jpg', awayTeamLogo: 'assets/images/itachi.jpg'/* match details */),
          Match(homeTeam: 'teram A', awayTeam: 'team B', homeScore: 1, awayScore: 2, matchStatus: 'live', matchTime: '19:48', homeTeamLogo: 'assets/images/itachi.jpg', awayTeamLogo: 'assets/images/itachi.jpg'/* match details */),
          Match(homeTeam: 'teram A', awayTeam: 'team B', homeScore: 1, awayScore: 2, matchStatus: 'live', matchTime: '19:48', homeTeamLogo: 'assets/images/itachi.jpg', awayTeamLogo: 'assets/images/itachi.jpg'/* match details */),
          Match(homeTeam: 'teram A', awayTeam: 'team B', homeScore: 1, awayScore: 2, matchStatus: 'live', matchTime: '19:48', homeTeamLogo: 'assets/images/itachi.jpg', awayTeamLogo: 'assets/images/itachi.jpg'/* match details */),
          Match(homeTeam: 'teram A', awayTeam: 'team B', homeScore: 1, awayScore: 2, matchStatus: 'live', matchTime: '19:48', homeTeamLogo: 'assets/images/itachi.jpg', awayTeamLogo: 'assets/images/itachi.jpg'/* match details */),
          Match(homeTeam: 'teram A', awayTeam: 'team B', homeScore: 1, awayScore: 2, matchStatus: 'live', matchTime: '19:48', homeTeamLogo: 'assets/images/itachi.jpg', awayTeamLogo: 'assets/images/itachi.jpg'/* match details */),

        ],
        leagueLogo: 'assets/images/jabami.jpg',
      ),
      League(
        leagueName: 'League c',
        matches: [
          Match(homeTeam: 'teram A', awayTeam: 'team B', homeScore: 1, awayScore: 2, matchStatus: 'live', matchTime: '19:48', homeTeamLogo: 'assets/images/itachi.jpg', awayTeamLogo: 'assets/images/itachi.jpg'/* match details */),
          Match(homeTeam: 'teram A', awayTeam: 'team B', homeScore: 1, awayScore: 2, matchStatus: 'live', matchTime: '19:48', homeTeamLogo: 'assets/images/itachi.jpg', awayTeamLogo: 'assets/images/itachi.jpg'/* match details */),
          Match(homeTeam: 'teram A', awayTeam: 'team B', homeScore: 1, awayScore: 2, matchStatus: 'live', matchTime: '19:48', homeTeamLogo: 'assets/images/itachi.jpg', awayTeamLogo: 'assets/images/itachi.jpg'/* match details */),

        ],
        leagueLogo: 'assets/images/jabami.jpg',
      ),
      League(
        leagueName: 'League B',
        matches: [
          Match(homeTeam: 'teram A', awayTeam: 'team B', homeScore: 1, awayScore: 2, matchStatus: 'live', matchTime: '19:48', homeTeamLogo: 'assets/images/itachi.jpg', awayTeamLogo: 'assets/images/itachi.jpg'/* match details */),
          Match(homeTeam: 'teram A', awayTeam: 'team B', homeScore: 1, awayScore: 2, matchStatus: 'live', matchTime: '19:48', homeTeamLogo: 'assets/images/itachi.jpg', awayTeamLogo: 'assets/images/itachi.jpg'/* match details */),
        ],
        leagueLogo: 'assets/images/jabami.jpg',
      ),
      // Add more leagues as needed
    ];

    return Column(
      children: [
        // Horizontally scrollable container for days
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: days.map((day) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Add action on tap if needed
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        day,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        // Vertically scrollable container for leagues
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 10),
            children: leagues.map((league) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: LeagueComponent(league: league),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
