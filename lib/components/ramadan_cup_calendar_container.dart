import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';
import 'package:untitled/components/Match_item_team_calendar.dart';
import 'package:untitled/components/match_item_live.dart';
import '../Service/data_service.dart';
import '../models/League.dart';
import '../models/Match.dart';
import '../models/PoolData.dart';
import '../models/Season.dart';
import 'image_slider.dart';
import 'package:intl/intl.dart';  // Import for date formatting

class PremierePhaseRamadanCalendarScreen extends StatefulWidget {
  final int league;
  final Function(Match) onMatchSelected;

  const PremierePhaseRamadanCalendarScreen({
    Key? key,
    required this.league,
    required this.onMatchSelected,
  }) : super(key: key);

  @override
  _PremierePhaseRamadanCalendarScreenState createState() => _PremierePhaseRamadanCalendarScreenState();
}

class _PremierePhaseRamadanCalendarScreenState extends State<PremierePhaseRamadanCalendarScreen> {
  final DataService dataService = DataService();
  List<PoolData> poolData = [];
  bool isMatchesLoading = true;
  bool isAdsLoading = true;
  List<String> imagePaths = [];

  // Maps to store matches grouped by pool
  Map<String, List<Match>> poolMatches = {};

  Season? selectedSeason = null;
  bool isSeasonsLoading = true;
  List<Season> seasonsList = [];

  @override
  void initState() {
    super.initState();
    _fetchSeasons();
    _fetchAds();
  }

  Future<void> _fetchSeasons() async {
    try {
      setState(() {
        isSeasonsLoading = true;
      });

      // Fetch all seasons
      final fetchedSeasons = await dataService.fetchSeasons();

      setState(() {
        // Find the first season where season.league?.id matches widget.league
        seasonsList = fetchedSeasons
            .where((season) => season.league?.id == widget.league)
            .toList();

        // If a matching season is found, assign it to selectedSeason
        if (seasonsList.isNotEmpty) {
          selectedSeason = seasonsList.first; // Take the first matching season
        } else {
          selectedSeason = null; // No matching season found
        }

        isSeasonsLoading = false;
      });

      print("Filtered seasons list: $seasonsList");

      // Fetch pool data after seasons are loaded
      if (selectedSeason != null) {
        _fetchPoolData();
      }
    } catch (e) {
      print('Error fetching seasons: $e');
      setState(() {
        isSeasonsLoading = false;
      });
    }
  }

  Future<void> _fetchPoolData() async {
    try {
      final fetchedPoolData = await dataService.fetchPoolData(selectedSeason?.id ?? 14);
      setState(() {
        poolData = fetchedPoolData;
        _groupMatchesByPool();
        isMatchesLoading = false;
      });
    } catch (e) {
      print("Error fetching pool data: $e");
      setState(() {
        isMatchesLoading = false;
      });
    }
  }

  // Group matches by pool
  void _groupMatchesByPool() {
    for (var pool in poolData) {
      if (pool.upcomingMatches != null && pool.upcomingMatches!.isNotEmpty) {
        poolMatches[pool.pool?.name ?? "Unnamed Pool"] = pool.upcomingMatches!;
      }
    }
    print("Pool Matches: $poolMatches");
  }

  Future<void> _fetchAds() async {
    try {
      final fetchedAds = await dataService.fetchAds();
      setState(() {
        imagePaths = fetchedAds
            .where((ad) => ad.place == "premiere_phase" && ad.image != null)
            .map((ad) => ad.image!)
            .toList();
        isAdsLoading = false;
      });
    } catch (e) {
      print("Error fetching ads: $e");
      setState(() {
        isAdsLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isSeasonsLoading || isMatchesLoading) {
      return Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return Container(
      child: Column(
        children: [
          // Display matches for each pool
          for (var poolName in poolMatches.keys) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        poolName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  // Underline
                  Container(
                    height: 2,
                    width: poolName.length * 8.0,
                    color: Colors.white,
                    margin: const EdgeInsets.only(top: 4),
                  ),
                ],
              ),
            ),
            // List of matches for the current pool
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 0),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true, // Allow ListView to fit within Column
                itemCount: poolMatches[poolName]?.length ?? 0,
                itemBuilder: (context, index) {
                  final matches = poolMatches[poolName];
                  if (matches == null || matches.isEmpty) {
                    return Container(); // Return empty if no matches
                  }
                  final match = matches[index];
                  return GestureDetector(
                    onTap: () {
                      widget.onMatchSelected(match);
                    },
                    child: MatchItemCalendar(
                      match: match,
                      backgroundColor: index.isEven ? Colors.transparent : Colors.transparent,
                      isLastItem: index == matches.length - 1,
                      isFirstItem: index == 0,
                    ),
                  );
                },
              ),
            ),
          ],
          // Image slider at the bottom
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: isAdsLoading
                ? const Center(
              child: CircularProgressIndicator(), // Loading icon
            )
                : Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: ImageSlider(
                imagePaths: imagePaths,
              ),
            ),
          ),
        ],
      ),
    );
  }
}