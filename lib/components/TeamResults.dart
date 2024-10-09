import 'package:flutter/material.dart';
import '../components/LeagueComponent.dart';
import '../models/MatchEvent.dart';
import '../models/Team.dart';
import '../models/league.dart';
import '../models/match.dart';
import '../models/player.dart';
import 'TeamLeagueComponent.dart';

class TeamResults extends StatefulWidget {
  final Function(Match)? onMatchSelected;

  const TeamResults({Key? key, this.onMatchSelected}) : super(key: key);

  @override
  _TeamResultsState createState() => _TeamResultsState();
}

class _TeamResultsState extends State<TeamResults> {
  // Sample list of leagues
  List<League> leagues = [
    League(
      leagueName: 'LIGUE SAMEDI',
      matches: [
        Match(
          homeTeam: Team(
            name: 'Ennakl',
            rank: 1,
            matchesPlayed: 12,
            goals: 15,
            points: 25,
            logo: 'assets/images/ennakl.jpg',
            players: [
              Player(name: 'Player A1', position: 'Forward', image: 'assets/images/ennakl.jpg'),
              // Add more players as needed
            ],
          ),
          awayTeam: Team(
            name: 'Monoprix',
            rank: 1,
            matchesPlayed: 12,
            goals: 15,
            points: 25,
            logo: 'assets/images/monoprix.jpg',
            players: [
              Player(name: 'Player B1', position: 'Forward', image: 'assets/images/monoprix.jpg'),
              // Add more players as needed
            ],
          ),
          homeScore: 1,
          awayScore: 2,
          matchStatus: 'finished',
          matchTime: '19:00',
          homeTeamLogo: 'assets/images/ennakl.jpg',
          awayTeamLogo: 'assets/images/monoprix.jpg',
          matchDate: DateTime.now(),
        ),
        Match(
          homeTeam: Team(
            name: 'Ennakl',
            rank: 1,
            matchesPlayed: 12,
            goals: 15,
            points: 25,
            logo: 'assets/images/ennakl.jpg',
            players: [
              Player(name: 'Player A1', position: 'Forward', image: 'assets/images/ennakl.jpg'),
              // Add more players as needed
            ],
          ),
          awayTeam: Team(
            name: 'Monoprix',
            rank: 1,
            matchesPlayed: 12,
            goals: 15,
            points: 25,
            logo: 'assets/images/monoprix.jpg',
            players: [
              Player(name: 'Player B1', position: 'Forward', image: 'assets/images/monoprix.jpg'),
              // Add more players as needed
            ],
          ),
          homeScore: 1,
          awayScore: 2,
          matchStatus: 'finished',
          matchTime: '19:00',
          homeTeamLogo: 'assets/images/ennakl.jpg',
          awayTeamLogo: 'assets/images/monoprix.jpg',
          matchDate: DateTime.now(),
        ),
        Match(
          homeTeam: Team(
            name: 'Ennakl',
            rank: 1,
            matchesPlayed: 12,
            goals: 15,
            points: 25,
            logo: 'assets/images/ennakl.jpg',
            players: [
              Player(name: 'Player A1', position: 'Forward', image: 'assets/images/ennakl.jpg'),
              // Add more players as needed
            ],
          ),
          awayTeam: Team(
            name: 'Monoprix',
            rank: 1,
            matchesPlayed: 12,
            goals: 15,
            points: 25,
            logo: 'assets/images/monoprix.jpg',
            players: [
              Player(name: 'Player B1', position: 'Forward', image: 'assets/images/monoprix.jpg'),
              // Add more players as needed
            ],
          ),
          homeScore: 1,
          awayScore: 2,
          matchStatus: 'finished',
          matchTime: '19:00',
          homeTeamLogo: 'assets/images/ennakl.jpg',
          awayTeamLogo: 'assets/images/monoprix.jpg',
          matchDate: DateTime.now(),
        ),
        Match(
          homeTeam: Team(
            name: 'Ennakl',
            rank: 1,
            matchesPlayed: 12,
            goals: 15,
            points: 25,
            logo: 'assets/images/ennakl.jpg',
            players: [
              Player(name: 'Player A1', position: 'Forward', image: 'assets/images/ennakl.jpg'),
              // Add more players as needed
            ],
          ),
          awayTeam: Team(
            name: 'Monoprix',
            rank: 1,
            matchesPlayed: 12,
            goals: 15,
            points: 25,
            logo: 'assets/images/monoprix.jpg',
            players: [
              Player(name: 'Player B1', position: 'Forward', image: 'assets/images/monoprix.jpg'),
              // Add more players as needed
            ],
          ),
          homeScore: 1,
          awayScore: 2,
          matchStatus: 'finished',
          matchTime: '19:00',
          homeTeamLogo: 'assets/images/ennakl.jpg',
          awayTeamLogo: 'assets/images/monoprix.jpg',
          matchDate: DateTime.now(),
        ),
        Match(
          homeTeam: Team(
            name: 'Ennakl',
            rank: 1,
            matchesPlayed: 12,
            goals: 15,
            points: 25,
            logo: 'assets/images/ennakl.jpg',
            players: [
              Player(name: 'Player A1', position: 'Forward', image: 'assets/images/ennakl.jpg'),
              // Add more players as needed
            ],
          ),
          awayTeam: Team(
            name: 'Monoprix',
            rank: 1,
            matchesPlayed: 12,
            goals: 15,
            points: 25,
            logo: 'assets/images/monoprix.jpg',
            players: [
              Player(name: 'Player B1', position: 'Forward', image: 'assets/images/monoprix.jpg'),
              // Add more players as needed
            ],
          ),
          homeScore: 1,
          awayScore: 2,
          matchStatus: 'finished',
          matchTime: '19:00',
          homeTeamLogo: 'assets/images/ennakl.jpg',
          awayTeamLogo: 'assets/images/monoprix.jpg',
          matchDate: DateTime.now(),
        ),
        // Add more matches as needed
      ],
      leagueLogo: 'assets/images/LIGUE_SAMEDI.png',
    ),
    // Add more leagues as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: Container(
          height: MediaQuery.of(context).size.height*0.6,
          width:MediaQuery.of(context).size.width ,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 0),
            children: leagues.map((league) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                child: TeamLeagueComponent(league: league,),
              );
            }).toList(),
          ),
        )
    );
  }
}
