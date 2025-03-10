import 'package:flutter/material.dart';
import 'package:untitled/dep/lib/flutter_tournament_bracket.dart';
import 'package:untitled/models/ramdan_matches.dart'; // Assuming RamadanMatches model exists
import '../Service/data_service.dart';
import '../models/Bracket.dart';
import '../models/Club.dart';
import '../models/Journey.dart';
import '../models/League.dart';
import '../models/Season.dart';
import '../models/Trophy.dart';
import '../models/ramadan_cup.dart';  // Assuming RamadanCup and League models exist
import 'bracketCard.dart';
import 'colors.dart';
import '../models/Match.dart';

class BracketsScreen extends StatefulWidget {
  final League league;

  const BracketsScreen({Key? key, required this.league}) : super(key: key);

  @override
  _BracketsScreenState createState() => _BracketsScreenState();
}

class _BracketsScreenState extends State<BracketsScreen> {
  List<Tournament> _tournaments = [];
  List<Tournament> _tournaments2 = [];
  bool _isLoading = true;
  String _errorMessage = '';
  Match? semiFinal1B1 = null;
  Match? semiFinal2B1 = null;
  Match? semiFinal1B2 = null;
  Match? semiFinal2B2 = null;
  Match? finalMatchB1 = null;
  Match? finalMatchB2 = null;

  final DataService dataService = DataService();

  Season? selectedSeason;
  bool isSeasonsLoading = true;
  List<Season> seasonsList = [];

  @override
  void initState() {
    super.initState();
    _fetchSeasons();
  }

  Future<void> _fetchSeasons() async {
    try {
      setState(() {
        isSeasonsLoading = true;
      });

      final fetchedSeasons = await dataService.fetchSeasons();

      setState(() {
        seasonsList = fetchedSeasons
            .where((season) => season.league?.id == widget.league.id)
            .toList();

        if (seasonsList.isNotEmpty) {
          selectedSeason = seasonsList.first;
        } else {
          selectedSeason = null;
        }

        isSeasonsLoading = false;
      });

      if (selectedSeason != null) {
        _loadBracketData(selectedSeason!.id!);
      }
    } catch (e) {
      setState(() {
        isSeasonsLoading = false;
        _errorMessage = 'Failed to load seasons: $e';
      });
    }
  }

  void _loadBracketData(int seasonId) async {
    try {
      final bracketDataList = await dataService.fetchBracketData(seasonId);
      _parseBracketData(bracketDataList);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load bracket data: $e';
      });
    }
  }


  Match createSampleMatch() {
    return Match(
      id: 1, // Sample ID
      home: null, // Sample home team
      away: null, // Sample away team
      date: DateTime.now(), // Current date and time
      venue: null, // Sample venue
      arbitres: [
      ],
      supervisors: null, // Sample supervisor
      home_first_half_score: 0, // Sample first half score for home team
      away_first_half_score: 0, // Sample first half score for away team
      home_second_half_score: 0, // Sample second half score for home team
      away_second_half_score: 0, // Sample second half score for away team
      status: "Finished", // Sample match status
      is_ended: true, // Match is ended
      trophy: null, // Sample trophy
      season: 2023, // Sample season
      premiere_phase: 1, // Sample premiere phase
      is_premiere_phase: true, // Is premiere phase
      is_playoff: false, // Is not playoff
      is_trophy: true, // Is trophy match
      is_super_trophy: false, // Is not super trophy
      is_super_playoff: false, // Is not super playoff
      is_coupe: false, // Is not coupe
      is_super_coupe: false, // Is not super coupe
      journey: null, // Sample journey
      time: "15:00", // Sample match time
    );
  }

  void _parseBracketData(List<BracketData> bracketDataList) {
    // Create a sample match to use as a fallback
    final sampleMatch = createSampleMatch();

    // Case 1: If bracketDataList is empty, create both tournaments with the sample match
    if (bracketDataList.isEmpty) {
      semiFinal1B1 = sampleMatch;
      semiFinal2B1 = sampleMatch;
      finalMatchB1 = sampleMatch;

      semiFinal1B2 = sampleMatch;
      semiFinal2B2 = sampleMatch;
      finalMatchB2 = sampleMatch;
    }
    // Case 2: If bracketDataList has only one object, create the first tournament with the data and the second with the sample match
    else if (bracketDataList.length == 1) {
      // Populate the first tournament with the data from bracketDataList[0]
      semiFinal1B1 = bracketDataList[0].matches.semiFinals[0] as Match?;
      semiFinal2B1 = bracketDataList[0].matches.semiFinals[1] as Match?;
      finalMatchB1 = bracketDataList[0].matches.finals[0] as Match?;

      // Populate the second tournament with the sample match
      semiFinal1B2 = sampleMatch;
      semiFinal2B2 = sampleMatch;
      finalMatchB2 = sampleMatch;
    }
    // Case 3: If bracketDataList has two objects, create both tournaments normally
    else if (bracketDataList.length >= 2) {
      // Populate the first tournament with the data from bracketDataList[0]
      semiFinal1B1 = bracketDataList[0].matches.semiFinals[0] as Match?;
      semiFinal2B1 = bracketDataList[0].matches.semiFinals[1] as Match?;
      finalMatchB1 = bracketDataList[0].matches.finals[0] as Match?;

      // Populate the second tournament with the data from bracketDataList[1]
      semiFinal1B2 = bracketDataList[1].matches.semiFinals[0] as Match?;
      semiFinal2B2 = bracketDataList[1].matches.semiFinals[1] as Match?;
      finalMatchB2 = bracketDataList[1].matches.finals[0] as Match?;
    }

    // Create the first tournament (_tournaments)
    _tournaments = [
      Tournament(matches: [
        TournamentMatch(
          id: "1",
          teamA: semiFinal1B1!.home?.name ?? "TBD",
          teamB: semiFinal1B1!.away?.name ?? "TBD",
          scoreTeamA: ((semiFinal1B1!.home_first_half_score ?? 0) +
              (semiFinal1B1!.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((semiFinal1B1!.away_first_half_score ?? 0) +
              (semiFinal1B1!.away_second_half_score ?? 0))
              .toString(),
          teamAImage: semiFinal1B1!.home?.logo ?? "",
          teamBImage: semiFinal1B1!.away?.logo ?? "",
        ),
        TournamentMatch(
          id: "2",
          teamA: semiFinal2B1!.home?.name ?? "TBD",
          teamB: semiFinal2B1!.away?.name ?? "TBD",
          scoreTeamA: ((semiFinal2B1!.home_first_half_score ?? 0) +
              (semiFinal2B1!.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((semiFinal2B1!.away_first_half_score ?? 0) +
              (semiFinal2B1!.away_second_half_score ?? 0))
              .toString(),
          teamAImage: semiFinal2B1!.home?.logo ?? "",
          teamBImage: semiFinal2B1!.away?.logo ?? "",
        ),
      ]),
      Tournament(matches: [
        TournamentMatch(
          id: "5",
          teamA: finalMatchB1!.home?.name ?? "TBD",
          teamB: finalMatchB1!.away?.name ?? "TBD",
          scoreTeamA: ((finalMatchB1!.home_first_half_score ?? 0) +
              (finalMatchB1!.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((finalMatchB1!.away_first_half_score ?? 0) +
              (finalMatchB1!.away_second_half_score ?? 0))
              .toString(),
          teamAImage: finalMatchB1!.home?.logo ?? "",
          teamBImage: finalMatchB1!.away?.logo ?? "",
        ),
      ]),
    ];

    // Create the second tournament (_tournaments2)
    _tournaments2 = [
      Tournament(matches: [
        TournamentMatch(
          id: "1",
          teamA: semiFinal1B2!.home?.name ?? "TBD",
          teamB: semiFinal1B2!.away?.name ?? "TBD",
          scoreTeamA: ((semiFinal1B2!.home_first_half_score ?? 0) +
              (semiFinal1B2!.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((semiFinal1B2!.away_first_half_score ?? 0) +
              (semiFinal1B2!.away_second_half_score ?? 0))
              .toString(),
          teamAImage: semiFinal1B2!.home?.logo ?? "",
          teamBImage: semiFinal1B2!.away?.logo ?? "",
        ),
        TournamentMatch(
          id: "2",
          teamA: semiFinal2B2!.home?.name ?? "TBD",
          teamB: semiFinal2B2!.away?.name ?? "TBD",
          scoreTeamA: ((semiFinal2B2!.home_first_half_score ?? 0) +
              (semiFinal2B2!.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((semiFinal2B2!.away_first_half_score ?? 0) +
              (semiFinal2B2!.away_second_half_score ?? 0))
              .toString(),
          teamAImage: semiFinal2B2!.home?.logo ?? "",
          teamBImage: semiFinal2B2!.away?.logo ?? "",
        ),
      ]),
      Tournament(matches: [
        TournamentMatch(
          id: "5",
          teamA: finalMatchB2!.home?.name ?? "TBD",
          teamB: finalMatchB2!.away?.name ?? "TBD",
          scoreTeamA: ((finalMatchB2!.home_first_half_score ?? 0) +
              (finalMatchB2!.home_second_half_score ?? 0))
              .toString(),
          scoreTeamB: ((finalMatchB2!.away_first_half_score ?? 0) +
              (finalMatchB2!.away_second_half_score ?? 0))
              .toString(),
          teamAImage: finalMatchB2!.home?.logo ?? "",
          teamBImage: finalMatchB2!.away?.logo ?? "",
        ),
      ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (isSeasonsLoading || _isLoading) {
      return Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Text(
          _errorMessage,
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            "RAMADAN CUP",
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TournamentBracket(
                cardWidth:  MediaQuery.of(context).size.width*0.8,
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
          Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            "ABC CUP",
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TournamentBracket(
                cardWidth:  MediaQuery.of(context).size.width*0.8,
                cardHeight:  MediaQuery.of(context).size.height*0.12,
                lineColor: Colors.white,
                list: _tournaments2, // Use the correctly created Tournament list
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
