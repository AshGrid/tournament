import 'package:flutter/material.dart';
import 'package:flutter_tournament_bracket/src/model/tournament_match.dart';
import 'package:flutter_tournament_bracket/src/model/tournament_model.dart';
import 'package:untitled/components/CustomMatchCard.dart';
import 'package:untitled/components/bracketCard.dart';
import 'package:untitled/components/brackets.dart';
import 'package:untitled/models/SuperPlayOff8.dart';

import '../Service/mock_data.dart';
import '../models/Coupe8.dart';
import '../models/Team.dart';
import '../models/Match.dart';
import 'colors.dart';

class Tropheehannibalveterantableau extends StatefulWidget {
  final SuperPlayOff8? superPlayOff8;
  const Tropheehannibalveterantableau({Key? key, required this.superPlayOff8}) : super(key: key);

  @override
  _TropheehannibalveterantableauState createState() => _TropheehannibalveterantableauState();
}

class _TropheehannibalveterantableauState extends State<Tropheehannibalveterantableau> {
  int selectedDayIndex = 0;









  @override
  Widget build(BuildContext context) {
    // Create a list of tournaments based on the selected phase
    final List<Tournament> _tournaments = [

      Tournament(matches: [
        TournamentMatch(
          id: "5",
          teamA: widget.superPlayOff8?.semi_final_1_Home?.home?.name ?? "TBD",
          teamB: widget.superPlayOff8?.semi_final_1_Home?.away?.name ?? "TBD",
          scoreTeamA: ((widget.superPlayOff8?.semi_final_1_Home?.home_first_half_score ?? 0) +
              (widget.superPlayOff8?.semi_final_1_Home?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.superPlayOff8?.semi_final_1_Home?.away_first_half_score ?? 0) +
              (widget.superPlayOff8?.semi_final_1_Home?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.superPlayOff8?.semi_final_1_Home?.home?.logo ?? "",
          teamBImage: widget.superPlayOff8?.semi_final_1_Home?.away?.logo ?? "",
        ),
        TournamentMatch(
          id: "6",
          teamA: widget.superPlayOff8?.semi_final_2_Home?.home?.name ?? "TBD",
          teamB: widget.superPlayOff8?.semi_final_2_Home?.away?.name ?? "TBD",
          scoreTeamA: ((widget.superPlayOff8?.semi_final_2_Home?.home_first_half_score ?? 0) +
              (widget.superPlayOff8?.semi_final_2_Home?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.superPlayOff8?.semi_final_2_Home?.away_first_half_score ?? 0) +
              (widget.superPlayOff8?.semi_final_2_Home?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.superPlayOff8?.semi_final_2_Home?.home?.logo ?? "",
          teamBImage: widget.superPlayOff8?.semi_final_2_Home?.away?.logo ?? "",
        ),
      ]),
      Tournament(matches: [
        TournamentMatch(
          id: "5",
          teamA: widget.superPlayOff8?.finalMatch?.home?.name ?? "TBD",
          teamB: widget.superPlayOff8?.finalMatch?.away?.name ?? "TBD",
          scoreTeamA: ((widget.superPlayOff8?.finalMatch?.home_first_half_score ?? 0) +
              (widget.superPlayOff8?.finalMatch?.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((widget.superPlayOff8?.finalMatch?.away_first_half_score ?? 0) +
              (widget.superPlayOff8?.finalMatch?.away_second_half_score ?? 0))
              .toString(),
          teamAImage: widget.superPlayOff8?.finalMatch?.home?.logo ?? "",
          teamBImage: widget.superPlayOff8?.finalMatch?.away?.logo ?? "",
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


