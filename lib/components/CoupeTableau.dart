import 'package:flutter/material.dart';

import 'package:untitled/components/CustomMatchCard.dart';
import 'package:untitled/components/bracketCard.dart';
import 'package:untitled/components/brackets.dart';
import '../dep/lib/src/model/tournament_match.dart';
import '../dep/lib/src/model/tournament_model.dart';
import '../Service/mock_data.dart';
import '../models/Coupe.dart';
import '../models/Team.dart';
import '../models/Match.dart';
import 'colors.dart';

class CoupeTableau extends StatefulWidget {
  final Coupe coupe;
  const CoupeTableau({Key? key, required this.coupe}) : super(key: key);

  @override
  _CoupeTableauTableauState createState() => _CoupeTableauTableauState();
}

class _CoupeTableauTableauState extends State<CoupeTableau> {
  int selectedDayIndex = 0;

  final List<String> phases = [
    'QUARTS DE FINALE',
    'DEMI-FINALE',
    'FINALE',
  ];



  @override
  Widget build(BuildContext context) {
    print("coupename in tableau ${widget.coupe.name}");
    // Create a list of tournaments based on the selected phase
    final List<Tournament> _tournaments = [
      Tournament(matches: [
        TournamentMatch(
          id: "1",
          teamA: widget.coupe.round_1?.home?.name ?? "TBD",
          teamB: widget.coupe.round_1?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe.round_1?.home_first_half_score ?? 0) +
              (widget.coupe.round_1?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe.round_1?.away_first_half_score ?? 0) +
              (widget.coupe.round_1?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.coupe.round_1?.home?.logo ?? "",
          teamBImage: widget.coupe.round_1?.away?.logo ?? "",
        ),
        TournamentMatch(
          id: "2",
          teamA: widget.coupe.round_2?.home?.name ?? "TBD",
          teamB: widget.coupe.round_2?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe.round_2?.home_first_half_score ?? 0) +
              (widget.coupe.round_2?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe.round_2?.away_first_half_score ?? 0) +
              (widget.coupe.round_2?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.coupe.round_2?.home?.logo ?? "",
          teamBImage: widget.coupe.round_2?.away?.logo ?? "",
        ),
        TournamentMatch(
          id: "3",
          teamA: widget.coupe.round_3?.home?.name ?? "TBD",
          teamB: widget.coupe.round_3?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe.round_3?.home_first_half_score ?? 0) +
              (widget.coupe.round_3?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe.round_3?.away_first_half_score ?? 0) +
              (widget.coupe.round_3?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.coupe.round_3?.home?.logo ?? "",
          teamBImage: widget.coupe.round_3?.away?.logo ?? "",
        ),
        TournamentMatch(
          id: "4",
          teamA: widget.coupe.round_4?.home?.name ?? "TBD",
          teamB: widget.coupe.round_4?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe.round_4?.home_first_half_score ?? 0) +
              (widget.coupe.round_4?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe.round_4?.away_first_half_score ?? 0) +
              (widget.coupe.round_4?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.coupe.round_4?.home?.logo ?? "",
          teamBImage: widget.coupe.round_4?.away?.logo ?? "",
        ),
        TournamentMatch(
          id: "5",
          teamA: widget.coupe.round_5?.home?.name ?? "TBD",
          teamB: widget.coupe.round_5?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe.round_5?.home_first_half_score ?? 0) +
              (widget.coupe.round_5?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe.round_5?.away_first_half_score ?? 0) +
              (widget.coupe.round_5?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.coupe.round_5?.home?.logo ?? "",
          teamBImage: widget.coupe.round_5?.away?.logo ?? "",
        ),
        TournamentMatch(
          id: "6",
          teamA: widget.coupe.round_6?.home?.name ?? "TBD",
          teamB: widget.coupe.round_6?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe.round_6?.home_first_half_score ?? 0) +
              (widget.coupe.round_6?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe.round_6?.away_first_half_score ?? 0) +
              (widget.coupe.round_6?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.coupe.round_6?.home?.logo ?? "",
          teamBImage: widget.coupe.round_6?.away?.logo ?? "",
        ),
        TournamentMatch(
          id: "7",
          teamA: widget.coupe.round_7?.home?.name ?? "TBD",
          teamB: widget.coupe.round_7?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe.round_7?.home_first_half_score ?? 0) +
              (widget.coupe.round_7?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe.round_7?.away_first_half_score ?? 0) +
              (widget.coupe.round_7?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.coupe.round_7?.home?.logo ?? "",
          teamBImage: widget.coupe.round_7?.away?.logo ?? "",
        ),
        TournamentMatch(
          id: "8",
          teamA: widget.coupe.round_8?.home?.name ?? "TBD",
          teamB: widget.coupe.round_8?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe.round_8?.home_first_half_score ?? 0) +
              (widget.coupe.round_8?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe.round_8?.away_first_half_score ?? 0) +
              (widget.coupe.round_8?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.coupe.round_8?.home?.logo ?? "",
          teamBImage: widget.coupe.round_8?.away?.logo ?? "",
        ),
      ]),
      Tournament(matches: [
        TournamentMatch(
          id: "9",
          teamA: widget.coupe.quarter_final_1?.home?.name ?? "TBD",
          teamB: widget.coupe.quarter_final_1?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe.quarter_final_1?.home_first_half_score ?? 0) +
              (widget.coupe.quarter_final_1?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe.quarter_final_1?.away_first_half_score ?? 0) +
              (widget.coupe.quarter_final_1?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.coupe.quarter_final_1?.home?.logo ?? "",
          teamBImage: widget.coupe.quarter_final_1?.away?.logo ?? "",
        ),
        TournamentMatch(
          id: "10",
          teamA: widget.coupe.quarter_final_2?.home?.name ?? "TBD",
          teamB: widget.coupe.quarter_final_2?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe.quarter_final_2?.home_first_half_score ?? 0) +
              (widget.coupe.quarter_final_2?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe.quarter_final_2?.away_first_half_score ?? 0) +
              (widget.coupe.quarter_final_2?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.coupe.quarter_final_2?.home?.logo ?? "",
          teamBImage: widget.coupe.quarter_final_2?.away?.logo ?? "",
        ),
        TournamentMatch(
          id: "11",
          teamA: widget.coupe.quarter_final_3?.home?.name ?? "TBD",
          teamB: widget.coupe.quarter_final_3?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe.quarter_final_3?.home_first_half_score ?? 0) +
              (widget.coupe.quarter_final_3?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe.quarter_final_3?.away_first_half_score ?? 0) +
              (widget.coupe.quarter_final_3?.away_second_half_score ?? 0))
              .toString(),
        ),
        TournamentMatch(
          id: "12",
          teamA: widget.coupe.quarter_final_4?.home?.name ?? "TBD",
          teamB: widget.coupe.quarter_final_4?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe.quarter_final_4?.home_first_half_score ?? 0) +
              (widget.coupe.quarter_final_4?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe.quarter_final_4?.away_first_half_score ?? 0) +
              (widget.coupe.quarter_final_4?.away_second_half_score ?? 0))
              .toString(),
        ),
      ]),
      Tournament(matches: [
        TournamentMatch(
          id: "13",
          teamA: widget.coupe.semi_final_1?.home?.name ?? "TBD",
          teamB: widget.coupe.semi_final_1?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe.semi_final_1?.home_first_half_score ?? 0) +
              (widget.coupe.semi_final_1?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe.semi_final_1?.away_first_half_score ?? 0) +
              (widget.coupe.semi_final_1?.away_second_half_score ?? 0))
              .toString(),
        ),
        TournamentMatch(
          id: "14",
          teamA: widget.coupe.semi_final_2?.home?.name ?? "TBD",
          teamB: widget.coupe.semi_final_2?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe.semi_final_2?.home_first_half_score ?? 0) +
              (widget.coupe.semi_final_2?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe.semi_final_2?.away_first_half_score ?? 0) +
              (widget.coupe.semi_final_2?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.coupe.semi_final_2?.home?.logo ?? "",
          teamBImage: widget.coupe.semi_final_2?.away?.logo ?? "",
        ),
      ]),
      Tournament(matches: [
        TournamentMatch(
          id: "15",
          teamA: widget.coupe.finalmatch?.home?.name ?? "TBD",
          teamB: widget.coupe.finalmatch?.away?.name ?? "TBD",
          scoreTeamA: ((widget.coupe.finalmatch?.home_first_half_score ?? 0) +
              (widget.coupe.finalmatch?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.coupe.finalmatch?.away_first_half_score ?? 0) +
              (widget.coupe.finalmatch?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.coupe.finalmatch?.home?.logo ?? "",
          teamBImage: widget.coupe.finalmatch?.away?.logo ?? "",
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
                cardWidth: MediaQuery.of(context).size.width * 0.8,
                cardHeight: MediaQuery.of(context).size.height * 0.12,
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
