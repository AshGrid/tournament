import 'package:flutter/material.dart';
import 'package:flutter_tournament_bracket/src/model/tournament_match.dart';
import 'package:flutter_tournament_bracket/src/model/tournament_model.dart';
import 'package:untitled/components/CustomMatchCard.dart';
import 'package:untitled/components/bracketCard.dart';
import 'package:untitled/components/brackets.dart';
import 'package:untitled/models/SuperPlayOff.dart';

import '../Service/data_service.dart';
import '../models/League.dart';
import '../models/Team.dart';
import '../models/Match.dart';

class SuperPlayOffTableau extends StatefulWidget {
  const SuperPlayOffTableau({Key? key, required this.playOff}) : super(key: key);

  final League playOff;

  @override
  _SuperPlayOffTableauState createState() => _SuperPlayOffTableauState();
}

class _SuperPlayOffTableauState extends State<SuperPlayOffTableau> {
  final DataService dataService = DataService();
  SuperPlayOff? superPlayoffList;

  static const List<String> phases = [
    'QUARTS DE FINALE',
    'DEMI-FINALE',
    'FINALE',
  ];

  @override
  void initState() {
    super.initState();
    _fetchSuperPlayoff();
  }

  Future<void> _fetchSuperPlayoff() async {
    try {
      final fetchedClubs = await dataService.fetchSuperPlayoff(widget.playOff.id!);
      setState(() {
        superPlayoffList = fetchedClubs;
      });
    } catch (error) {
      print("Error fetching Super PlayOff: $error");
    }
  }

  List<Tournament> _createTournaments() {

    return [
      Tournament(matches: _createQuarterFinalMatches()),
      Tournament(matches: _createSemiFinalMatches()),
      Tournament(matches: _createFinalMatches()),
    ];
  }

  List<TournamentMatch> _createQuarterFinalMatches() {
    if (superPlayoffList == null) return [];
    return [
      _createDefaultTournamentMatch(
        id: "1",
        teamA: superPlayoffList!.quarter_final_1_home?.home?.name ?? "TBD",
        teamB: superPlayoffList!.quarter_final_1_away?.away?.name ?? "TBD",
        scoreTeamA: _calculateScore(superPlayoffList!.quarter_final_1_home),
        scoreTeamB: _calculateScore(superPlayoffList!.quarter_final_1_away),
        teamAImage: superPlayoffList!.quarter_final_1_home?.home?.logo ?? "",
        teamBImage: superPlayoffList!.quarter_final_1_away?.away?.logo ?? "",
      ),
      // Add more matches...
    ];
  }

  List<TournamentMatch> _createSemiFinalMatches() {
    if (superPlayoffList == null) return [];
    return [
      _createDefaultTournamentMatch(
        id: "11",
        teamA: superPlayoffList!.semi_final_1_home?.home?.name ?? "TBD",
        teamB: superPlayoffList!.semi_final_1_away?.away?.name ?? "TBD",
        scoreTeamA: _calculateScore(superPlayoffList!.semi_final_1_home),
        scoreTeamB: _calculateScore(superPlayoffList!.semi_final_1_away),
        teamAImage: superPlayoffList!.semi_final_1_home?.home?.logo ?? "",
        teamBImage: superPlayoffList!.semi_final_1_away?.away?.logo ?? "",
      ),
      // Add more matches...
    ];
  }

  List<TournamentMatch> _createFinalMatches() {
    if (superPlayoffList == null) return [];
    return [
      _createDefaultTournamentMatch(
        id: "21",
        teamA: superPlayoffList!.finalmatch?.home?.name ?? "TBD",
        teamB: superPlayoffList!.finalmatch?.away?.name ?? "TBD",
        scoreTeamA: _calculateScore(superPlayoffList!.finalmatch),
        scoreTeamB: _calculateScore(superPlayoffList!.finalmatch),
        teamAImage: superPlayoffList!.finalmatch?.home?.logo ?? "",
        teamBImage: superPlayoffList!.finalmatch?.away?.logo ?? "",
      ),
    ];
  }

  String _calculateScore(Match? match) {
    if (match == null) return "0";
    return ((match.home_first_half_score ?? 0) + (match.home_second_half_score ?? 0)).toString();
  }

  TournamentMatch _createDefaultTournamentMatch({
    required String id,
    required String teamA,
    required String teamB,
    required String scoreTeamA,
    required String scoreTeamB,
    required String teamAImage,
    required String teamBImage,
  }) {
    return TournamentMatch(
      id: id,
      teamA: teamA.isNotEmpty ? teamA : "Team A",
      teamB: teamB.isNotEmpty ? teamB : "Team B",
      scoreTeamA: scoreTeamA.isNotEmpty ? scoreTeamA : "0",
      scoreTeamB: scoreTeamB.isNotEmpty ? scoreTeamB : "0",
      teamAImage: teamAImage.isNotEmpty ? teamAImage : "default_team_a_logo.png",
      teamBImage: teamBImage.isNotEmpty ? teamBImage : "default_team_b_logo.png",
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Tournament> tournaments = _createTournaments();

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
                list: tournaments,
                card: (item) => BracketMatchCard(item: item),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
