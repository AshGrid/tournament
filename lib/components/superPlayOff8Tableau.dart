import 'package:flutter/material.dart';

import 'package:untitled/components/CustomMatchCard.dart';
import 'package:untitled/components/bracketCard.dart';
import 'package:untitled/components/brackets.dart';
import 'package:untitled/models/SuperPlayOff.dart';
import '../dep/lib/src/model/tournament_match.dart';
import '../dep/lib/src/model/tournament_model.dart';
import '../Service/data_service.dart';
import '../models/League.dart';
import '../models/SuperPlayOff8.dart';
import '../models/Team.dart';
import '../models/Match.dart';

class SuperPlayOff8Tableau extends StatefulWidget {
  const SuperPlayOff8Tableau({Key? key, required this.playOff}) : super(key: key);

  final League playOff;

  @override
  _SuperPlayOff8TableauState createState() => _SuperPlayOff8TableauState();
}

class _SuperPlayOff8TableauState extends State<SuperPlayOff8Tableau> {
  final DataService dataService = DataService();
  SuperPlayOff8? superPlayoffList;
SuperPlayOff8? selectedSuperPlayoff;
  bool isLoading = true; // Loading state
  static const List<String> phases = [

    'DEMI-FINALE',
    'FINALE',
  ];

  @override
  void initState() {
    super.initState();
   // _fetchSuperPlayoff();
    _fetchSuperPlayoff8ByLeagueId(widget.playOff.id!);
  }

  Future<void> _fetchSuperPlayoff() async {
    try {
      final fetchedClubs = await dataService.fetchSuperPlayoff8(widget.playOff.id!);
      // setState(() {
      //   superPlayoffList = fetchedClubs;
      // });
    } catch (error) {
      print("Error fetching Super PlayOff: $error");
    }
  }

  Future<void> _fetchSuperPlayoff8ByLeagueId(int leagueId) async {
    setState(() {
      isLoading = true; // Show loading indicator
    });
    try {
      final fetchedSuperPlayoff = await dataService.fetchSuperPlayoff8ByLeagueId(leagueId);
      setState(() {
        superPlayoffList = fetchedSuperPlayoff;
      });
      if (fetchedSuperPlayoff != null) {
        print("SuperPlayOff8 found: ${superPlayoffList?.id}");
        print(superPlayoffList?.semi_final_1_Home);
      } else {
        print("No SuperPlayOff8 found for league ID $leagueId.");
      }
    } catch (error) {
      print("Error fetching SuperPlayOff8: $error");
    } finally {
      setState(() {
        isLoading = false; // Hide loading indicator
      });
    }
  }



  List<Tournament> _createTournaments() {

    return [

      Tournament(matches: _createSemiFinalMatches()),
      Tournament(matches: _createFinalMatches()),
    ];
  }



  List<TournamentMatch> _createSemiFinalMatches() {

    return [
      _createDefaultTournamentMatch(
        id: "5",
        teamA: superPlayoffList?.semi_final_1_Home?.home?.name ?? "TBD",
        teamB: superPlayoffList?.semi_final_1_Home?.away?.name ?? "TBD",
        scoreTeamA: _calculateScore(superPlayoffList?.semi_final_1_Home),
        scoreTeamB: _calculateAwayScore(superPlayoffList?.semi_final_1_Home),
        scoreTeamAAway: _calculateAwayScore(superPlayoffList?.semi_final_1_Away),
        scoreTeamBHome: _calculateScore(superPlayoffList?.semi_final_1_Away),
        teamAImage: superPlayoffList?.semi_final_1_Home?.home?.logo ?? "",
        teamBImage: superPlayoffList?.semi_final_1_Home?.away?.logo ?? "",
      ),
      _createDefaultTournamentMatch(
        id: "6",
        teamA: superPlayoffList?.semi_final_2_Home?.home?.name ?? "TBD",
        teamB: superPlayoffList?.semi_final_2_Home?.away?.name ?? "TBD",
        scoreTeamA: _calculateScore(superPlayoffList?.semi_final_2_Home),
        scoreTeamB: _calculateAwayScore(superPlayoffList?.semi_final_2_Home),
        scoreTeamAAway: _calculateAwayScore(superPlayoffList?.semi_final_2_Away),
        scoreTeamBHome: _calculateScore(superPlayoffList?.semi_final_2_Away),
        teamAImage: superPlayoffList?.semi_final_2_Home?.home?.logo ?? "",
        teamBImage: superPlayoffList?.semi_final_2_Home?.away?.logo ?? "",
      ),
      // Add more matches...
    ];
  }

  List<TournamentMatch> _createFinalMatches() {

    return [
      _createDefaultTournamentMatch(
        id: "21",
        teamA: superPlayoffList?.finalMatch?.home?.name ?? "TBD",
        teamB: superPlayoffList?.finalMatch?.away?.name ?? "TBD",
        scoreTeamA: _calculateScoreFinalHome(superPlayoffList?.finalMatch),
        scoreTeamB: _calculateScoreFinal(superPlayoffList?.finalMatch),
        teamAImage: superPlayoffList?.finalMatch?.home?.logo ?? "",
        teamBImage: superPlayoffList?.finalMatch?.away?.logo ?? "",
      ),
    ];
  }

  String _calculateScore(Match? match) {
    if (match == null) return "-";
    return ((match.home_first_half_score ?? 0) + (match.home_second_half_score ?? 0)).toString();
  }
  String _calculateAwayScore(Match? match) {
    if (match == null) return "-";
    return ((match.away_first_half_score ?? 0) + (match.away_second_half_score ?? 0)).toString();
  }
  String _calculateScoreFinal(Match? match) {
    if (match == null) return "-";
    return ((match.away_first_half_score ?? 0) + (match.away_second_half_score ?? 0)).toString();
  }
  String _calculateScoreFinalHome(Match? match) {
    if (match == null) return "-";
    return ((match.home_first_half_score ?? 0) + (match.home_second_half_score ?? 0)).toString();
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
      scoreTeamA: scoreTeamA.isNotEmpty ? scoreTeamA : "-",
      scoreTeamB: scoreTeamB.isNotEmpty ? scoreTeamB : "-",
      scoreTeamAAway: scoreTeamAAway ?? " ",
      scoreTeamBHome: scoreTeamBHome ?? " ",
      teamAImage: teamAImage.isNotEmpty ? teamAImage : "default_team_a_logo.png",
      teamBImage: teamBImage.isNotEmpty ? teamBImage : "default_team_b_logo.png",
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(), // Loading indicator
      );
    }
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
