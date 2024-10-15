import 'package:flutter/material.dart';
import 'package:flutter_tournament_bracket/src/model/tournament_match.dart';
import 'package:flutter_tournament_bracket/src/model/tournament_model.dart';
import 'package:untitled/components/CustomMatchCard.dart';
import 'package:untitled/components/bracketCard.dart';
import 'package:untitled/components/brackets.dart';

import '../Service/mock_data.dart';
import '../models/Coupe8.dart';
import '../models/Team.dart';
import '../models/Match.dart';
import 'colors.dart';

class Coupe8Tableau extends StatefulWidget {
  final Coupe8 coupe8;
  const Coupe8Tableau({Key? key, required this.coupe8}) : super(key: key);

  @override
  _Coupe8TableauTableauState createState() => _Coupe8TableauTableauState();
}

class _Coupe8TableauTableauState extends State<Coupe8Tableau> {
  int selectedDayIndex = 0;

  final List<String> phases = [
    'QUARTS DE FINALE',
    'DEMI-FINALE',
    'FINALE',
  ];

  final Map<String, List<Match>> matchesByPhase = {
    'QUARTS DE FINALE': MockData.mockMatches,
    'DEMI-FINALE': MockData.mockMatches,
    'FINALE':MockData.mockMatches,
  };





  @override
  Widget build(BuildContext context) {
    // Create a list of tournaments based on the selected phase
    final List<Tournament> _tournaments = [
      Tournament(matches: [
        TournamentMatch(
          id: "1",
          teamA: widget.coupe8.quarter_final_1?.home?.name ?? "TBD",
          teamB: widget.coupe8.quarter_final_1?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe8.quarter_final_1?.home_first_half_score ?? 0) +
              (widget.coupe8.quarter_final_1?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe8.quarter_final_1?.away_first_half_score ?? 0) +
              (widget.coupe8.quarter_final_1?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.coupe8.quarter_final_1?.home?.logo ?? "",
          teamBImage: widget.coupe8.quarter_final_1?.away?.logo ?? "",
        ),
        TournamentMatch(
          id: "2",
          teamA: widget.coupe8.quarter_final_2?.home?.name ?? "TBD",
          teamB: widget.coupe8.quarter_final_2?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe8.quarter_final_2?.home_first_half_score ?? 0) +
              (widget.coupe8.quarter_final_2?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe8.quarter_final_2?.away_first_half_score ?? 0) +
              (widget.coupe8.quarter_final_2?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.coupe8.quarter_final_2?.home?.logo ?? "",
          teamBImage: widget.coupe8.quarter_final_2?.away?.logo ?? "",
        ),
        TournamentMatch(
          id: "3",
          teamA: widget.coupe8.quarter_final_3?.home?.name ?? "TBD",
          teamB: widget.coupe8.quarter_final_3?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe8.quarter_final_3?.home_first_half_score ?? 0) +
              (widget.coupe8.quarter_final_3?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe8.quarter_final_3?.away_first_half_score ?? 0) +
              (widget.coupe8.quarter_final_3?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.coupe8.quarter_final_3?.home?.logo ?? "",
          teamBImage: widget.coupe8.quarter_final_3?.away?.logo ?? "",
        ),
        TournamentMatch(
          id: "4",
          teamA: widget.coupe8.quarter_final_4?.home?.name ?? "TBD",
          teamB: widget.coupe8.quarter_final_4?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe8.quarter_final_4?.home_first_half_score ?? 0) +
              (widget.coupe8.quarter_final_4?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe8.quarter_final_4?.away_first_half_score ?? 0) +
              (widget.coupe8.quarter_final_4?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.coupe8.quarter_final_4?.home?.logo ?? "",
          teamBImage: widget.coupe8.quarter_final_4?.away?.logo ?? "",
        ),
      ]),
      Tournament(matches: [
        TournamentMatch(
          id: "5",
          teamA: widget.coupe8.semi_final_1?.home?.name ?? "TBD",
          teamB: widget.coupe8.semi_final_1?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe8.semi_final_1?.home_first_half_score ?? 0) +
              (widget.coupe8.semi_final_1?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe8.semi_final_1?.away_first_half_score ?? 0) +
              (widget.coupe8.semi_final_1?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.coupe8.semi_final_1?.home?.logo ?? "",
          teamBImage: widget.coupe8.semi_final_1?.away?.logo ?? "",
        ),
        TournamentMatch(
          id: "6",
          teamA: widget.coupe8.semi_final_2?.home?.name ?? "TBD",
          teamB: widget.coupe8.semi_final_1?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe8.semi_final_1?.home_first_half_score ?? 0) +
              (widget.coupe8.semi_final_1?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe8.semi_final_1?.away_first_half_score ?? 0) +
              (widget.coupe8.semi_final_1?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.coupe8.semi_final_1?.home?.logo ?? "",
          teamBImage: widget.coupe8.semi_final_1?.away?.logo ?? "",
        ),
      ]),
      Tournament(matches: [
        TournamentMatch(
          id: "5",
          teamA: widget.coupe8.finalMatch?.home?.name ?? "TBD",
          teamB: widget.coupe8.finalMatch?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe8.finalMatch?.home_first_half_score ?? 0) +
              (widget.coupe8.finalMatch?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe8.finalMatch?.away_first_half_score ?? 0) +
              (widget.coupe8.finalMatch?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.coupe8.finalMatch?.home?.logo ?? "",
          teamBImage: widget.coupe8.finalMatch?.away?.logo ?? "",
        ),

      ]),
    ];


    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

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


