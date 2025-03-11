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

    // Initialize matches with sample match
    semiFinal1B1 = sampleMatch;
    semiFinal2B1 = sampleMatch;
    finalMatchB1 = sampleMatch;

    semiFinal1B2 = sampleMatch;
    semiFinal2B2 = sampleMatch;
    finalMatchB2 = sampleMatch;

    if (bracketDataList.isNotEmpty) {
      // Populate the first tournament if it exists
      if (bracketDataList.length >= 1) {
        final matchesB1 = bracketDataList[0].matches;

        if (matchesB1.semiFinals.length > 0) {
          semiFinal1B1 = matchesB1.semiFinals[0] ?? sampleMatch;
        }
        if (matchesB1.semiFinals.length > 1) {
          semiFinal2B1 = matchesB1.semiFinals[1] ?? sampleMatch;
        }
        if (matchesB1.finals.isNotEmpty) {
          finalMatchB1 = matchesB1.finals[0] ?? sampleMatch;
        }
      }

      // Populate the second tournament if available
      if (bracketDataList.length >= 2) {
        final matchesB2 = bracketDataList[1].matches;

        if (matchesB2.semiFinals.length > 0) {
          semiFinal1B2 = matchesB2.semiFinals[0] ?? sampleMatch;
        }
        if (matchesB2.semiFinals.length > 1) {
          semiFinal2B2 = matchesB2.semiFinals[1] ?? sampleMatch;
        }
        if (matchesB2.finals.isNotEmpty) {
          finalMatchB2 = matchesB2.finals[0] ?? sampleMatch;
        }
      }
    }

    // Create the first tournament (_tournaments)
    _tournaments = [
      Tournament(matches: [
        _createTournamentMatch("1", semiFinal1B1!),
        _createTournamentMatch("2", semiFinal2B1!),
      ]),
      Tournament(matches: [
        _createTournamentMatch("5", finalMatchB1!),
      ]),
    ];

    // Create the second tournament (_tournaments2)
    _tournaments2 = [
      Tournament(matches: [
        _createTournamentMatch("1", semiFinal1B2!),
        _createTournamentMatch("2", semiFinal2B2!),
      ]),
      Tournament(matches: [
        _createTournamentMatch("5", finalMatchB2!),
      ]),
    ];
  }

// Helper function to create TournamentMatch
  TournamentMatch _createTournamentMatch(String id, Match match) {
    return TournamentMatch(
      id: id,
      teamA: match.home?.name ?? "TBD",
      teamB: match.away?.name ?? "TBD",
      scoreTeamA: ((match.home_first_half_score ?? 0) +
          (match.home_second_half_score ?? 0))
          .toString(),
      scoreTeamB: ((match.away_first_half_score ?? 0) +
          (match.away_second_half_score ?? 0))
          .toString(),
      teamAImage: match.home?.logo ?? "",
      teamBImage: match.away?.logo ?? "",
    );
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
