import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/colors.dart';
import '../components/leagueFavoriteComponent.dart';
import '../models/league.dart';
import '../models/match.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // Sample list of leagues with DateTime type for the date
  final List<League> leagues = [
    League(
      leagueName: 'LIGUE SAMEDI',
      matches: [
        Match(
          homeTeam: 'ennakl',
          awayTeam: 'monoprix',
          homeScore: 1,
          awayScore: 2,
          matchStatus: 'finished',
          matchTime: '19`',
          homeTeamLogo: 'assets/images/ennakl.jpg',
          awayTeamLogo: 'assets/images/ennakl.jpg',
        ),
        Match(
          homeTeam: 'ennakl',
          awayTeam: 'monoprix',
          homeScore: 1,
          awayScore: 2,
          matchStatus: 'live',
          matchTime: '19`',
          homeTeamLogo: 'assets/images/ennakl.jpg',
          awayTeamLogo: 'assets/images/ennakl.jpg',
        ),
      ],
      date: DateTime(2024, 10, 6),
      leagueLogo: 'assets/images/LIGUE SAMEDI.png',
    ),
    League(
      leagueName: 'LIGUE DIMANCHE',
      matches: [
        Match(
          homeTeam: 'ennakl',
          awayTeam: 'monoprix',
          homeScore: 1,
          awayScore: 2,
          matchStatus: 'live',
          matchTime: '19`',
          homeTeamLogo: 'assets/images/ennakl.jpg',
          awayTeamLogo: 'assets/images/ennakl.jpg',
        ),
        Match(
          homeTeam: 'ennakl',
          awayTeam: 'monoprix',
          homeScore: 1,
          awayScore: 2,
          matchStatus: 'finished',
          matchTime: '19`',
          homeTeamLogo: 'assets/images/ennakl.jpg',
          awayTeamLogo: 'assets/images/ennakl.jpg',
        ),
      ],
      date: DateTime(2024, 10, 6),
      leagueLogo: 'assets/images/LIGUE DIMANCHE.png',
    ),
    League(
      leagueName: 'LIGUE IT',
      matches: [
        Match(
          homeTeam: 'ennakl',
          awayTeam: 'monoprix',
          homeScore: 1,
          awayScore: 2,
          matchStatus: 'live',
          matchTime: '19`',
          homeTeamLogo: 'assets/images/ennakl.jpg',
          awayTeamLogo: 'assets/images/ennakl.jpg',
        ),
      ],
      date: DateTime(2024, 10, 6),
      leagueLogo: 'assets/images/LIGUE IT.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Horizontally scrollable container for days (if needed, add this here),

        // Vertically scrollable container for leagues
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 15),
            itemCount: leagues.length,
            itemBuilder: (context, index) {
              final league = leagues[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display formatted date
                    Text(
                      DateFormat('MMMM d, yyyy').format(league.date!),
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 3.0,
                            color: AppColors.textShadow,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // League component
                    LeagueFavoriteComponent(league: league),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
