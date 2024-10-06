import 'package:flutter/material.dart';
import 'package:flutter_tournament_bracket/src/model/tournament_match.dart';
import 'package:flutter_tournament_bracket/src/model/tournament_model.dart';
import 'package:untitled/components/CustomMatchCard.dart';
import 'package:untitled/components/bracketCard.dart';
import 'package:untitled/components/brackets.dart';

import '../models/match.dart';
import 'colors.dart';

class Tropheehannibaltableau extends StatefulWidget {
  const Tropheehannibaltableau({Key? key}) : super(key: key);

  @override
  _TropheehannibaltableauState createState() => _TropheehannibaltableauState();
}

class _TropheehannibaltableauState extends State<Tropheehannibaltableau> {
  int selectedDayIndex = 0;

  final List<String> phases = [
    'QUARTS DE FINALE',
    'DEMI-FINALE',
    'FINALE',
  ];

  final Map<String, List<Match>> matchesByPhase = {
    'QUARTS DE FINALE': [
      Match(
        homeTeam: 'Monoprix',
        awayTeam: 'Carrefour',
        homeScore: 1,
        awayScore: 2,
        matchStatus: 'finished',
        matchTime: '19:00',
        homeTeamLogo: 'assets/images/ennakl.jpg',
        awayTeamLogo: 'assets/images/carrefour.jpg',
      ),
      Match(
        homeTeam: 'Carrefour',
        awayTeam: 'Geant',
        homeScore: 3,
        awayScore: 1,
        matchStatus: 'finished',
        matchTime: '18:00',
        homeTeamLogo: 'assets/images/carrefour.jpg',
        awayTeamLogo: 'assets/images/geant.jpg',
      ),
    ],
    'DEMI-FINALE': [
      Match(
        homeTeam: 'Monoprix',
        awayTeam: 'Carrefour',
        homeScore: 1,
        awayScore: 2,
        matchStatus: 'finished',
        matchTime: '19:00',
        homeTeamLogo: 'assets/images/ennakl.jpg',
        awayTeamLogo: 'assets/images/carrefour.jpg',
      ),
    ],
    'FINALE': [
      Match(
        homeTeam: 'Monoprix',
        awayTeam: 'Carrefour',
        homeScore: 2,
        awayScore: 1,
        matchStatus: 'live',
        matchTime: '20:00',
        homeTeamLogo: 'assets/images/ennakl.jpg',
        awayTeamLogo: 'assets/images/carrefour.jpg',
      ),
    ],
  };


  final List<Tournament> _tournaments = [

    Tournament(matches: [
      TournamentMatch(id: "1", teamA: "ennakl", teamB: "monoprix", scoreTeamA: "3", scoreTeamB: "1"),
      TournamentMatch(id: "2", teamA: "monoprix", teamB: "ennakl", scoreTeamA: "0", scoreTeamB: "1"),
      TournamentMatch(id: "3", teamA: "ennakl", teamB: "monoprix", scoreTeamA: "0", scoreTeamB: "2"),
      TournamentMatch(id: "4", teamA: "monoprix", teamB: "ennakl", scoreTeamA: "4", scoreTeamB: "2"),
    ]),
    Tournament(matches: [
      TournamentMatch(id: "1", teamA: "ennakl", teamB: "monoprix", scoreTeamA: "4", scoreTeamB: "0"),
      TournamentMatch(id: "2", teamA: "monoprix", teamB: "ennakl", scoreTeamA: "2", scoreTeamB: "1"),
    ]),
    Tournament(matches: [
      TournamentMatch(id: "1", teamA: "ennakl", teamB: "monoprix", scoreTeamA: "4", scoreTeamB: "3"),
    ])
  ];


  @override
  Widget build(BuildContext context) {
    // Create a list of tournaments based on the selected phase


    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phase selector (quarterfinals, semifinals, final)
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 10),
          //     child: Row(
          //       children: phases.asMap().entries.map((entry) {
          //         int index = entry.key;
          //         String phase = entry.value;
          //         bool isSelected = index == selectedDayIndex;
          //
          //         return Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //           child: GestureDetector(
          //             onTap: () {
          //               setState(() {
          //                 selectedDayIndex = index;
          //               });
          //             },
          //             child: Column(
          //               mainAxisSize: MainAxisSize.min,
          //               children: [
          //                 Text(
          //                   phase,
          //                   style: TextStyle(
          //                     color: Colors.white,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //                 if (isSelected)
          //                   Container(
          //                     margin: const EdgeInsets.only(top: 5),
          //                     width: 100,
          //                     height: 2,
          //                     color: Colors.white,
          //                   ),
          //               ],
          //             ),
          //           ),
          //         );
          //       }).toList(),
          //     ),
          //   ),
          // ),
          // Matches List Container
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TournamentBracket(
                cardWidth:  MediaQuery.of(context).size.width*0.7,
                cardHeight:  MediaQuery.of(context).size.height*0.12,
                lineColor: Colors.white,
                list: _tournaments, // Use the correctly created Tournament list
                card: (item) {
                  return BracketMatchCard(
                    item: item,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


