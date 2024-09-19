import 'package:flutter/material.dart';
import '../components/LeagueComponent.dart';
import '../models/league.dart';
import '../models/match.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  _MatchesScreenState createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  // Track the selected day
  int selectedDayIndex = 0;

  // Sample list of days to display
  final List<String> days = [
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
      leagueName: 'LEAGUE SAMEDI',
      matches: [
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 1, awayScore: 2, matchStatus: 'finished', matchTime: '19\`', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/ennakl.jpg'/* match details */),
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 1, awayScore: 2, matchStatus: 'live', matchTime: '19\`', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/ennakl.jpg'/* match details */),
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 1, awayScore: 2, matchStatus: 'finished', matchTime: '19\`', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/ennakl.jpg'/* match details */),
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 1, awayScore: 2, matchStatus: 'finished', matchTime: '19\`', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/ennakl.jpg'/* match details */),
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 1, awayScore: 2, matchStatus: 'live', matchTime: '19\`', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/ennakl.jpg'/* match details */),
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 1, awayScore: 2, matchStatus: 'live', matchTime: '19\`', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/ennakl.jpg'/* match details */),

      ],
      leagueLogo: 'assets/images/LIGUE SAMEDI.png',
    ),
    League(
      leagueName: 'LEAGUE DIMANCHE',
      matches: [
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 1, awayScore: 2, matchStatus: 'live', matchTime: '19\`', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/ennakl.jpg'/* match details */),
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 1, awayScore: 2, matchStatus: 'finished', matchTime: '19\`', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/ennakl.jpg'/* match details */),
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 1, awayScore: 2, matchStatus: 'live', matchTime: '19\`', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/ennakl.jpg'/* match details */),

      ],
      leagueLogo: 'assets/images/LIGUE DIMANCHE.png',
    ),
    League(
      leagueName: 'LEAGUE IT',
      matches: [
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 1, awayScore: 2, matchStatus: 'live', matchTime: '19\`', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/ennakl.jpg'/* match details */),
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 1, awayScore: 2, matchStatus: 'finished', matchTime: '19\`', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/ennakl.jpg'/* match details */),
      ],
      leagueLogo: 'assets/images/LIGUE IT.png',
    ),
    // Add more leagues as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Horizontally scrollable container for days
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: days.asMap().entries.map((entry) {
                int index = entry.key;
                String day = entry.value;
                bool isSelected = index == selectedDayIndex;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDayIndex = index;
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          day,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isSelected)
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: 70, // Adjust this to match the desired underline width
                            height: 2,  // Height of the underline
                            color: Colors.white, // Underline color
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        )

        ,
        // Vertically scrollable container for leagues
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 0),
            children: leagues.map((league) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                child: LeagueComponent(league: league),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
