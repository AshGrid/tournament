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
  List<League> leaguesList = [];
  List<DateTime> dayss = [];
  List<Match> matches = [];
  bool isTrophiesLoading = true;
  bool isMatchesLoading = true;
  bool isLeaguesLoading = true;
  bool isDaysLoading = true;

  Future<void> _fetchTrophies() async {
    try {
      final fetchedTrophies = await dataService.fetchTrophies();
      setState(() {
        trophiesList = fetchedTrophies..sort((a, b) => a.name!.compareTo(b.name!));
        isTrophiesLoading = false;
      });
    } catch (error) {
      setState(() {
        isTrophiesLoading = false;
      });
    }
  }

  Future<void> _fetchDays() async {
    try {
      print("fetching days");
      final fetchedDays = await dataService.fetchUpcomingMatchDates();
      setState(() {
        if (fetchedDays.isNotEmpty) {
          dayss = fetchedDays;
        }

        isDaysLoading = false;
      });
    } catch (error) {
      setState(() {
        isDaysLoading = false;
      });
    }
  }

  Future<void> _fetchLeagues() async {
    try {
      final fetchedLeagues = await dataService.fetchLeagues();
      print("Fetched leagues: $fetchedLeagues");
      setState(() {
        leaguesList = fetchedLeagues;
        isLeaguesLoading = false;
      });
    } catch (error) {
      print("Error fetching leagues: $error");
      setState(() {
        isLeaguesLoading = false;
      });
    }
  }

  Future<void> _fetchMatches() async {
    try {
      final fetchedMatches = await dataService.fetchPlayedMatches();
      final fetchedUpcomingMatches = await dataService.fetchUpcomingMatches();
      print("Fetched upcoming matches: $fetchedMatches");
      setState(() {
        matches = [...fetchedMatches, ...fetchedUpcomingMatches];
        isMatchesLoading = false;
      });
    } catch (error) {
      print("Error fetching matches: $error");
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
    _fetchLeagues();
    _fetchDays();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = isTrophiesLoading || isMatchesLoading || isLeaguesLoading||isDaysLoading;

    // Filter trophies that have leagues with matches
    final List<Trophy> trophiesWithMatches = trophiesList.where((trophy) {
      return leaguesList.where((league) {
        return league.trophy?.id == trophy.id &&
            matches.where((match) => match.home?.league == league.id || match.away?.league == league.id).isNotEmpty;
      }).isNotEmpty;
    }).toList();

    // Trophies with no leagues or no matches
    final List<Trophy> trophiesWithoutMatches = trophiesList.where((trophy) {
      return !trophiesWithMatches.contains(trophy);
    }).toList();

    // Combine trophies with matches first, followed by those without
    final List<Trophy> sortedTrophies = [...trophiesWithMatches, ...trophiesWithoutMatches];

    // Get the selected date
    DateTime selectedDate ;
    if (dayss.length > 0) {
      selectedDate = dayss[selectedDayIndex];
    } else {
      selectedDate = DateTime.now();
    }

    return Column(
      children: [
        // Horizontally scrollable container for days
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: dayss.asMap().entries.map((entry) {
                int index = entry.key;
                DateTime day = entry.value;
                bool isSelected = index == selectedDayIndex;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDayIndex = index; // Update selected day index
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${day.day}/${day.month}/${day.year}",
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

        // Vertically scrollable container for leagues/trophies
        Expanded(
          child: isLoading
              ? Center(child: CircularProgressIndicator(color: Colors.white))
              : ListView.builder(
            itemCount: sortedTrophies.length,
            itemBuilder: (context, trophyIndex) {
              final trophy = sortedTrophies[trophyIndex];

              // Filter the leagues where league.trophy.id equals trophy.id
              final filteredLeagues = leaguesList.where((league) {
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
                          // Filter the matches based on league.trophy.id == match.trophy.id and the selected date
                          final filteredMatches = matches.where((match) {
                            // Check if the date matches
                            final matchDate = match.date;
                            return (match.home?.league == league.id || match.away?.league == league.id) &&
                                (matchDate != null && matchDate.year == selectedDate.year &&
                                    matchDate.month == selectedDate.month &&
                                    matchDate.day == selectedDate.day);
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
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: Colors.white, width: 1.0),
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
                                      'assets/images/${league.name?.toUpperCase() ?? 'default'}.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),

                              // Display matches for the league
                              if (filteredMatches.isNotEmpty)
                                Column(
                                  children: filteredMatches.map((match) {
                                    return GestureDetector(
                                      onTap: () {
                                        widget.onMatchSelected(match);
                                      },
                                      child: MatchItem(match: match, backgroundColor: Colors.transparent, isLastItem: false, isFirstItem: true,),
                                    );
                                  }).toList(),
                                ),
                            ],
                          );
                        }).toList(),
                      ),
                    )
                  else
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'No leagues found for this trophy.',
                        style: TextStyle(color: Colors.white, fontSize: 16),
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
