import 'package:flutter/material.dart';
import 'package:untitled/components/TeamItem.dart';
import 'package:untitled/components/colors.dart';
import 'package:untitled/models/Club.dart';
import 'package:untitled/models/PoolData.dart';
import '../Service/data_service.dart';
import '../models/League.dart';
import '../models/Season.dart';
import '../models/TeamRanking.dart';
import 'image_slider.dart';

class PremierePhaseRamadanRankingScreen extends StatefulWidget {
  final League league;
  final List<TeamRanking> clubs;
  final Club? club;

  PremierePhaseRamadanRankingScreen({
    required this.league,
    required this.clubs,
    this.club,
  });

  @override
  _PremierePhaseRamadanRankingScreenState createState() => _PremierePhaseRamadanRankingScreenState();
}

class _PremierePhaseRamadanRankingScreenState extends State<PremierePhaseRamadanRankingScreen> {
  bool isAdsLoading = true;
  bool isRankingsLoading = true;
  final DataService dataService = DataService();

  List<String> imagePaths = [];
  List<PoolData> poolData = [];

  Season? selectedSeason;
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
        // Find the first season where season.league?.id matches widget.league.id
        seasonsList = fetchedSeasons
            .where((season) => season.league?.id == widget.league.id)
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
        _fetchPoolData(selectedSeason!.id!);
      }
    } catch (e) {
      print('Error fetching seasons: $e');
      setState(() {
        isSeasonsLoading = false;
      });
    }
  }

  Future<void> _fetchPoolData(int id) async {
    try {
      final fetchedPoolData = await dataService.fetchPoolData(id);
      setState(() {
        poolData = fetchedPoolData;
        isRankingsLoading = false;
      });
    } catch (e) {
      print("Error fetching pool data: $e");
      setState(() {
        isRankingsLoading = false;
      });
    }
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
      print("Error fetching ads for home screen: $e");
      setState(() {
        isAdsLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isSeasonsLoading || isRankingsLoading) {
      return Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: [
          // Display rankings for each pool
          ...poolData.map((pool) {
            return _buildPoolRankingContainer(pool);
          }).toList(),

          // Ads section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: isAdsLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: ImageSlider(imagePaths: imagePaths),
            ),
          ),
        ],
      ),
    );
  }

  // Method to build a ranking container for a single pool
  Widget _buildPoolRankingContainer(PoolData pool) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pool name
          Text(
            pool.pool?.name ?? "Unnamed Pool",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),

          // Table headers
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 40, child: Text('#', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                SizedBox(width: 140, child: Text('EQUIPE', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(width: 60, child: Text('MJ', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(width: 60, child: Text('B', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(width: 60, child: Text('PTS', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          const Divider(),

          // Rankings list
          Container(
            height: 200, // Fixed height for the rankings list
            child: SingleChildScrollView(
              child: Column(
                children: pool.rankings?.asMap().entries.map((entry) {
                  int index = entry.key;
                  TeamRanking ranking = entry.value;
                  return TeamItem(club: ranking.club!, index: index, ranking: ranking);
                }).toList() ?? [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}