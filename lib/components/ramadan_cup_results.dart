import 'package:flutter/material.dart';
import 'package:untitled/components/phaseMatchResultItem.dart';
import '../Service/data_service.dart';
import '../models/Match.dart';
import 'image_slider.dart';

class RamadanCupResults extends StatefulWidget {
  final int seasonId; // Accept seasonId as a parameter

  const RamadanCupResults({
    Key? key,
    required this.seasonId, // Required seasonId
  }) : super(key: key);

  @override
  _RamadanCupResultsState createState() => _RamadanCupResultsState();
}

class _RamadanCupResultsState extends State<RamadanCupResults> {
  int selectedDayIndex = 0;
  bool isAdsLoading = true;
  bool isMatchesLoading = true;
  final DataService dataService = DataService();

  List<String> imagePaths = [];
  List<Match> semiFinals = [];
  List<Match> finals = [];

  final List<String> phases = ['Demi-Finals', 'Finals'];

  @override
  void initState() {
    super.initState();
    _fetchAds();
    _fetchBracketData();
  }

  Future<void> _fetchAds() async {
    try {
      final fetchedAds = await dataService.fetchAds();
      setState(() {
        imagePaths = fetchedAds
            .where((ad) => ad.place == "home_swiper" && ad.image != null)
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

  Future<void> _fetchBracketData() async {
    try {
      final bracketDataList = await dataService.fetchBracketData(widget.seasonId);
      print("Fetched BracketData: $bracketDataList"); // Debugging

      // Clear previous data to avoid duplicate matches
      semiFinals.clear();
      finals.clear();

      // Extract matches from each bracket
      for (var bracketData in bracketDataList) {
        final matches = bracketData.matches;

        // Add semi-finals (1_2) and finals from each bracket
        setState(() {
          semiFinals.addAll(matches.semiFinals ?? []);
          finals.addAll(matches.finals ?? []);
        });
      }

      setState(() {
        isMatchesLoading = false;
      });
    } catch (e) {
      print("Error fetching bracket data: $e");
      setState(() {
        isMatchesLoading = false;
      });
    }
  }


  // Organize matches by phase and filter where is_ended = true
  Map<String, List<Match>> matchesByPhase() {
    return {
      'Demi-Finals': semiFinals
          .where((match) => match.is_ended!) // Filter where is_ended = true
          .toList(),
      'Finals': finals
          .where((match) => match.is_ended!) // Filter where is_ended = true
          .toList(),
    };
  }

  @override
  Widget build(BuildContext context) {
    if (isMatchesLoading) {
      return Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    // Get matches grouped by phase
    Map<String, List<Match>> groupedMatches = matchesByPhase();

    return SingleChildScrollView(
      child: Column(
        children: [
          // Phase selection tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: phases.asMap().entries.map((entry) {
                  int index = entry.key;
                  String phase = entry.value;
                  bool isSelected = index == selectedDayIndex;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDayIndex = index;
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            phase,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (isSelected)
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              width: 70,
                              height: 2,
                              color: Colors.white,
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Display matches for the selected phase
          ListView.builder(
            shrinkWrap: true, // Add this
            physics: NeverScrollableScrollPhysics(), // Disable scrolling for the inner ListView
            itemCount: groupedMatches[phases[selectedDayIndex]]?.length ?? 0,
            itemBuilder: (context, index) {
              final match = groupedMatches[phases[selectedDayIndex]]?[index];
              if (match == null) return SizedBox.shrink(); // Skip null matches

              return PhaseMatchResultItem(
                match: match,
                backgroundColor: index.isEven ? Colors.transparent : Colors.transparent,
                isLastItem: index == (groupedMatches[phases[selectedDayIndex]]?.length ?? 0) - 1,
                isFirstItem: index == 0,
              );
            },
          ),

          // Ads section
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