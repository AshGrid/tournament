import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';
import '../Service/data_service.dart';
import '../components/LeagueComponent.dart';
import '../components/colors.dart';
import '../components/match_item.dart';
import '../components/match_item_live.dart';
import '../models/MatchEvent.dart';
import '../models/Team.dart';
import '../models/League.dart';
import '../models/Match.dart';
import '../models/Player.dart';
import '../models/Trophy.dart';
import 'package:collection/collection.dart';

class MatchesScreen extends StatefulWidget {
  final Function(Match) onMatchSelected;

  const MatchesScreen({Key? key, required this.onMatchSelected}) : super(key: key);

  @override
  _MatchesScreenState createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  int selectedDayIndex = 0;

  final DataService dataService = DataService();
  List<Trophy> trophiesList = [];
  List<League> leagues = MockData.mockLeagues; // Your mock data for leagues
  List<Match> matches = []; // Your mock data for matches
  bool isTrophiesLoading = true; // For tracking trophies loading state
  bool isMatchesLoading = true; // For tracking matches loading state

  Future<void> _fetchTrophies() async {
    try {
      final fetchedTrophies = await dataService.fetchTrophies();
      setState(() {
        trophiesList = fetchedTrophies..sort((a, b) => a.name!.compareTo(b.name!));
        isTrophiesLoading = false; // Set to false once trophies are loaded
      });
    } catch (error) {
      setState(() {
        isTrophiesLoading = false;
      });
    }
  }

  Future<void> _fetchMatches() async {
    try {
      final fetchedMatches = await dataService.fetchPlayedMatches();
      final fetchedUpcomingMatches = await dataService.fetchUpcomingMatches();
      setState(() {
        matches = [...fetchedMatches];  // Initialize matches with fetchedMatches
        matches.addAll(fetchedUpcomingMatches);  // Append upcoming matches
        isMatchesLoading = false; // Set to false once matches are loaded
      });
    } catch (error) {
      setState(() {
        isMatchesLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchTrophies();
    _fetchMatches();
  }

  final List<String> days = [
    'Journée 1',
    'Journée 2',
    'Journée 3',
    'Journée 4',
    'Journée 5',
    'Journée 6',
    'Journée 7',
  ];

  @override
  Widget build(BuildContext context) {
    bool isLoading = isTrophiesLoading || isMatchesLoading; // Determine if still loading
    return Column(
      children: [
        // Horizontally scrollable container for days
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: days.asMap().entries.map((entry) {
                int index = entry.key;
                String day = entry.value;
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
                          day,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isSelected)
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: day.length * 7.0,
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

        // Vertically scrollable container for leagues/trophies
        Expanded(
          child: isLoading
              ? Center(child: CircularProgressIndicator(color: Colors.white))
              : ListView.builder(
            itemCount: trophiesList.length,
            itemBuilder: (context, trophyIndex) {
              final trophy = trophiesList[trophyIndex];

              // Filter the leagues where league.trophy.id equals trophy.id
              final filteredLeagues = leagues.where((league) {
                return league.trophy?.id == trophy.id;
              }).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.bottomSheetItem,
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFFFFFFF), width: 2),
                        top: BorderSide(color: Color(0xFFFFFFFF), width: 2),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      leading: Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: AppColors.bottomSheetLogo,
                            width: 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 4.0,
                              spreadRadius: 0.0,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset(
                            'assets/images/${trophy.name?.toUpperCase() ?? 'default'}.png',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      title: Text(
                        trophy.name?.toUpperCase() ?? 'UNKNOWN TROPHY',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "oswald",
                          shadows: [
                            Shadow(
                              blurRadius: 4.0,
                              color: AppColors.textShadow,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Display the list of leagues filtered by trophy id
                  if (filteredLeagues.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 8.0, bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: filteredLeagues.map((league) {
                          // Filter the matches based on league.trophy.id == match.trophy.id
                          final filteredMatches = matches.where((match) {
                            return match.home?.league == league.id;
                          }).toList();

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(
                                  league.name!.toUpperCase() ?? 'Unknown League',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Oswald',
                                  ),
                                ),
                                leading: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                      color: AppColors.bottomSheetLogo,
                                      width: 1.0,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        blurRadius: 4.0,
                                        spreadRadius: 0.0,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Image.asset(
                                      'assets/images/${league.name!.toUpperCase()}.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                              if (filteredMatches.isNotEmpty)
                                Column(
                                  children: filteredMatches.mapIndexed((index, match) {
                                    bool isFirstItem = index == 0;
                                    bool isLastItem = index == filteredMatches.length - 1;
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            widget.onMatchSelected(match);
                                          },
                                          child:
                                          MatchItem(
                                            match: match,
                                            backgroundColor: Colors.transparent,
                                            isFirstItem: isFirstItem,
                                            isLastItem: isLastItem,
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              if (filteredMatches.isEmpty)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: Text(
                                    'aucun match disponible pour cette ligue',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  if (filteredLeagues.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        'No leagues available for this trophy',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

