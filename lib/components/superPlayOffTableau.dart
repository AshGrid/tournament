import 'package:flutter/material.dart';
import '../dep/lib/src/model/tournament_match.dart';
import '../dep/lib/src/model/tournament_model.dart';
import 'package:untitled/components/CustomMatchCard.dart';
import 'package:untitled/components/bracketCard.dart';
import 'package:untitled/components/brackets.dart';
import 'package:untitled/models/SuperPlayOff.dart';

import '../Service/data_service.dart';
import '../models/League.dart';
import '../models/SuperPlayOff8.dart';
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
  SuperPlayOff8? superPlayoff8List;

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

  Future<void> _fetchSuperPlayoff8() async {
    try {
      final fetchedClubs = await dataService.fetchSuperPlayoff8(widget.playOff.id!);
      setState(() {
        superPlayoff8List = fetchedClubs;
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

    return [
      _createDefaultTournamentMatch(
        id: "1",
        teamA: superPlayoffList?.quarter_final_1_home?.home?.name ?? "TBD",
        teamB: superPlayoffList?.quarter_final_1_home?.away?.name ?? "TBD",
        scoreTeamA: _calculateScore(superPlayoffList?.quarter_final_1_home),
        scoreTeamB: _calculateAwayScore(superPlayoffList?.quarter_final_1_home),
        scoreTeamAAway: _calculateAwayScore(superPlayoffList?.quarter_final_1_away),
        scoreTeamBHome: _calculateScore(superPlayoffList?.quarter_final_1_away),
        teamAImage: superPlayoffList?.quarter_final_1_home?.home?.logo ?? "",
        teamBImage: superPlayoffList?.quarter_final_1_home?.away?.logo ?? "",
      ),
      _createDefaultTournamentMatch(
        id: "2",
        teamA: superPlayoffList?.quarter_final_2_home?.home?.name ?? "TBD",
        teamB: superPlayoffList?.quarter_final_2_away?.away?.name ?? "TBD",
        scoreTeamA: _calculateScore(superPlayoffList?.quarter_final_2_home),
        scoreTeamB: _calculateAwayScore(superPlayoffList?.quarter_final_2_away),
        scoreTeamAAway: _calculateAwayScore(superPlayoffList?.quarter_final_2_away),
        scoreTeamBHome: _calculateScore(superPlayoffList?.quarter_final_2_away),
        teamAImage: superPlayoffList?.quarter_final_1_home?.home?.logo ?? "",
        teamBImage: superPlayoffList?.quarter_final_1_home?.away?.logo ?? "",
      ),
      _createDefaultTournamentMatch(
        id: "3",
        teamA: superPlayoffList?.quarter_final_3_home?.home?.name ?? "TBD",
        teamB: superPlayoffList?.quarter_final_3_away?.away?.name ?? "TBD",
        scoreTeamA: _calculateScore(superPlayoffList?.quarter_final_3_home),
        scoreTeamB: _calculateAwayScore(superPlayoffList?.quarter_final_3_home),
        scoreTeamAAway: _calculateAwayScore(superPlayoffList?.quarter_final_3_away),
        scoreTeamBHome: _calculateScore(superPlayoffList?.quarter_final_3_away),
        teamAImage: superPlayoffList?.quarter_final_3_home?.home?.logo ?? "",
        teamBImage: superPlayoffList?.quarter_final_3_home?.away?.logo ?? "",
      ),
      _createDefaultTournamentMatch(
        id: "4",
        teamA: superPlayoffList?.quarter_final_4_home?.home?.name ?? "TBD",
        teamB: superPlayoffList?.quarter_final_4_home?.away?.name ?? "TBD",
        scoreTeamA: _calculateScore(superPlayoffList?.quarter_final_4_home),
        scoreTeamB: _calculateAwayScore(superPlayoffList?.quarter_final_4_home),
        scoreTeamAAway: _calculateAwayScore(superPlayoffList?.quarter_final_4_away),
        scoreTeamBHome: _calculateScore(superPlayoffList?.quarter_final_4_away),
        teamAImage: superPlayoffList?.quarter_final_4_home?.home?.logo ?? "",
        teamBImage: superPlayoffList?.quarter_final_4_home?.away?.logo ?? "",
      ),
      // Add more matches...
    ];
  }

  List<TournamentMatch> _createSemiFinalMatches() {

    return [
      _createDefaultTournamentMatch(
        id: "5",
        teamA: superPlayoffList?.semi_final_1_home?.home?.name ?? "TBD",
        teamB: superPlayoffList?.semi_final_1_home?.away?.name ?? "TBD",
        scoreTeamA: _calculateScore(superPlayoffList?.semi_final_1_home),
        scoreTeamB: _calculateAwayScore(superPlayoffList?.semi_final_1_home),
        scoreTeamAAway: _calculateAwayScore(superPlayoffList?.semi_final_1_away),
        scoreTeamBHome: _calculateScore(superPlayoffList?.semi_final_1_away),
        teamAImage: superPlayoffList?.semi_final_1_home?.home?.logo ?? "",
        teamBImage: superPlayoffList?.semi_final_1_home?.away?.logo ?? "",
      ),
      _createDefaultTournamentMatch(
        id: "6",
        teamA: superPlayoffList?.semi_final_2_home?.home?.name ?? "TBD",
        teamB: superPlayoffList?.semi_final_2_home?.away?.name ?? "TBD",
        scoreTeamA: _calculateScore(superPlayoffList?.semi_final_2_home),
        scoreTeamB: _calculateAwayScore(superPlayoffList?.semi_final_2_home),
        scoreTeamAAway: _calculateAwayScore(superPlayoffList?.semi_final_2_away),
        scoreTeamBHome: _calculateScore(superPlayoffList?.semi_final_2_away),
        teamAImage: superPlayoffList?.semi_final_2_home?.home?.logo ?? "",
        teamBImage: superPlayoffList?.semi_final_2_home?.away?.logo ?? "",
      ),
      // Add more matches...
    ];
  }

  List<TournamentMatch> _createFinalMatches() {

    return [
      _createDefaultTournamentMatch(
        id: "21",
        teamA: superPlayoffList?.finalmatch?.home?.name ?? "TBD",
        teamB: superPlayoffList?.finalmatch?.away?.name ?? "TBD",
        scoreTeamA: _calculateScore(superPlayoffList?.finalmatch),
        scoreTeamB: _calculateAwayScore(superPlayoffList?.finalmatch),
        teamAImage: superPlayoffList?.finalmatch?.home?.logo ?? "",
        teamBImage: superPlayoffList?.finalmatch?.away?.logo ?? "",
      ),
    ];
  }

  String _calculateScore(Match? match) {
    if (match == null) return "0";
    return ((match.home_first_half_score ?? 0) + (match.home_second_half_score ?? 0)).toString();
  }
  String _calculateAwayScore(Match? match) {
    if (match == null) return "0";
    return ((match.away_first_half_score ?? 0) + (match.away_second_half_score ?? 0)).toString();
  }
  TournamentMatch _createDefaultTournamentMatch({
    required String id,
    required String teamA,
    required String teamB,
    required String scoreTeamA,
    required String scoreTeamB,
     String? scoreTeamAAway,
     String? scoreTeamBHome,
    required String teamAImage,
    required String teamBImage,
  }) {
    return TournamentMatch(
      id: id,
      teamA: teamA.isNotEmpty ? teamA : "Team A",
      teamB: teamB.isNotEmpty ? teamB : "Team B",
      scoreTeamA: scoreTeamA.isNotEmpty ? scoreTeamA : "0",
      scoreTeamB: scoreTeamB.isNotEmpty ? scoreTeamB : "0",
      scoreTeamAAway: scoreTeamAAway ?? " ",
      scoreTeamBHome: scoreTeamBHome ?? " ",
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
