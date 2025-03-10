import 'package:flutter/material.dart';
import 'package:untitled/components/TropheeHannibalVeteranTableau.dart';
import 'package:untitled/components/TropheehannibalcalendarVeteran.dart';
import 'package:untitled/components/TropheehannibalresultasVeteran.dart';
import 'package:untitled/components/superPlayOff8Calendar.dart';
import 'package:untitled/components/superPlayOffCalendar.dart';
import 'package:untitled/components/superPlayOffResultats.dart';
import 'package:untitled/components/tropheeHannibalCalendar.dart';
import 'package:untitled/components/tropheeHannibalResultats.dart';
import 'package:untitled/components/tropheeHannibalTableau.dart';
import 'package:untitled/models/League.dart';
import 'package:untitled/models/SuperPlayOff.dart';
import 'package:untitled/models/Trophy.dart';
import '../Service/data_service.dart';
import '../components/calendarContainer.dart';
import '../components/colors.dart';
import '../components/ramadan_cup_calendar.dart';
import '../components/ramadan_cup_calendar_container.dart';
import '../components/ramadan_cup_ranking_screen.dart';
import '../components/ramadan_cup_results.dart';
import '../components/ramadan_cup_results_screen.dart';
import '../components/ramadan_cup_tableau_screen.dart';
import '../components/rankingContainer.dart';
import '../components/resultsContainer.dart';
import '../components/superPlayOff8Resultats.dart';
import '../components/superPlayOff8Tableau.dart';
import '../components/superPlayOffCalendar.dart';
import '../components/superPlayOffTableau.dart';
import '../models/Club.dart';
import '../models/Match.dart';
import '../models/Coupe8.dart';
import '../models/PoolData.dart';
import '../models/Season.dart';
import '../models/SuperPlayOff8.dart';
import '../models/TeamRanking.dart';

class RamadanCupPhaseDetailsScreen extends StatefulWidget {
  final String phaseName;
  final League league;
  final Trophy trophy;
  final Function(Match) onMatchSelected;

  const RamadanCupPhaseDetailsScreen({
    Key? key,
    required this.phaseName,
    required this.league,
    required this.trophy,
    required this.onMatchSelected,
  }) : super(key: key);

  @override
  _RamadanCupPhaseDetailsScreenState createState() =>
      _RamadanCupPhaseDetailsScreenState();
}

class _RamadanCupPhaseDetailsScreenState
    extends State<RamadanCupPhaseDetailsScreen> {
  final DataService dataService = DataService();
  int selectedIndex = 0;
  List<Coupe8> coupes8List = []; // List for Coupe8
  List<String> years = List.generate(
      7, (index) => (19 + index).toString()); // Years from 2010 to 2024
  String selectedYear = '24'; // Default selected year

  late Coupe8? league_superTrophy = null;

  SuperPlayOff8? hannibalTrophies;

  List<Club> clubsList = [];
  List<TeamRanking> clubsListPremierePhase = [];
  SuperPlayOff? superPlayoffList;
  SuperPlayOff8? superPlayoff8List;

  Season? selectedSeason = null;
  bool isSeasonsLoading = true;
  List<Season> seasonsList = [];
  List<PoolData> poolData = [];
  bool isPoolDataLoading = true;
  List<TeamRanking> rankingsList = [];

  Future<void> fetchAndProcessPoolData() async {
    try {
      // Fetch the pool data
      List<PoolData> poolDataList =
          await dataService.fetchPoolData(selectedSeason?.id ?? 14);

      // Check if the pool data list is not empty
      if (poolDataList.isNotEmpty) {
        // Initialize a list to store all rankings
        List<TeamRanking> allRankings = [];

        // Loop through each PoolData object
        for (var poolData in poolDataList) {
          // Check if the rankings list is not null
          if (poolData.rankings != null) {
            // Add the rankings to the allRankings list
            allRankings.addAll(poolData.rankings!);
          }
        }

        // Now `allRankings` contains all the rankings from all PoolData objects
        print('Total rankings fetched: ${allRankings.length}');

        // You can now use `allRankings` as needed in your app
        // For example, assign it to a variable or state
        setState(() {
          rankingsList =
              allRankings; // Assuming `rankingsList` is a state variable
        });
      } else {
        print('No pool data found.');
      }
    } catch (e) {
      print('Error processing pool data: $e');
    }
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
    } catch (e) {
      print('Error fetching seasons: $e');
      setState(() {
        isSeasonsLoading = false;
      });
    }
  }

  void loadPoolData() async {
    print("selected season id${selectedSeason?.id}");
    List<PoolData> poolDataList =
        await dataService.fetchPoolData(selectedSeason?.id ?? 14);
    print("pool data list: $poolDataList");
    if (poolDataList.isNotEmpty) {
      print('Pool data found: $poolDataList');
      // Use the poolDataList in your app
      setState(() {
        poolData = poolDataList;
        isPoolDataLoading = false;
      });
    } else {
      print('No pool data found or an error occurred.');
    }
  }

  Future<void> _fetchClubsByPremierePhase() async {
    print("league id");
    print(widget.league.id);

    try {
      final fetchedClubs =
          await dataService.fetchRankingByLeague(widget.league.id!);
      print("fetched clubs premirephase by league id");

      // Sort the clubs by teamranking.points in descending order
      fetchedClubs.sort((a, b) => b.points!.compareTo(a.points!));

      setState(() {
        clubsListPremierePhase = fetchedClubs; // Use the sorted list
      });

      print(clubsListPremierePhase); // Log the sorted clubs
    } catch (error) {
      print('Error fetching clubs: $error');
      // Handle error if necessary
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSeasons();
    fetchAndProcessPoolData();
    _fetchClubsByPremierePhase();

    if (this.widget.phaseName == "PHASE ELIMINATOIRE") {
      selectedIndex = 3; // or whatever index you need
    } else {
      selectedIndex = 0; // default index
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Coupe8> filteredCoupes8 = coupes8List
        .where((coupe8) =>
            coupe8.season!.league?.trophy!.name!.toUpperCase() ==
            widget.trophy.name?.toUpperCase())
        .toList();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.backgroundColor),
        child: CustomScrollView(
          slivers: [
            // Phase Details Header
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: AppColors.trophyComponent,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 8,
                      offset: const Offset(0, 1),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // League Name and Logo in the first container
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: AppColors.trophyTitleComponent,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.transparent.withOpacity(0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // League Image in a rounded container
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                              border:
                                  Border.all(color: Colors.black12, width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/${widget.league.name!.toUpperCase()}.png',
                                  fit: BoxFit.contain,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // League Name
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.trophy.name!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "RAMADAN CUP",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      widget.phaseName,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    // List of Phases in the same container
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (this.widget.phaseName == "PREMIERE PHASE") ...[
                            _buildMenuItem('CLASSEMENT', 0),
                            const SizedBox(width: 20),
                            _buildMenuItem('RESULTATS', 1),
                            const SizedBox(width: 20),
                            _buildMenuItem('CALENDRIER', 2),
                          ],
                          if (this.widget.phaseName ==
                              "PHASE ELIMINATOIRE") ...[
                            _buildMenuItem('TABLEAU', 3),
                            const SizedBox(width: 20),
                            _buildMenuItem('RESULTATS', 4),
                            const SizedBox(width: 20),
                            _buildMenuItem('CALENDRIER', 5),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            // Display the selected content - now below the container
            SliverToBoxAdapter(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
                child: _buildSelectedContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build each menu item
  Widget _buildMenuItem(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index; // Set selected index
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13,
              fontFamily: "oswald",
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          // Underline only for the selected item
          if (selectedIndex == index)
            Container(
              height: 2,
              width: title.length * 8.0,
              color: Colors.black,
            ),
        ],
      ),
    );
  }

  // Method to build the selected content
  Widget _buildSelectedContent() {
    switch (selectedIndex) {
      case 0:
        return PremierePhaseRamadanRankingScreen(
          clubs: rankingsList,
          league: widget.league,
        ); // Display RankingScreen
      case 1:
        return PremierePhaseRamadanResultsScreen(
            league: widget.league.id!,
            onMatchSelected: widget.onMatchSelected); // Display ResultsScreen
      case 2:
        return PremierePhaseRamadanCalendarScreen(
          league: widget.league.id!,
          onMatchSelected: widget.onMatchSelected,
        ); // Display CalendarScreen
      case 3:
        return
          // Wrap BracketsScreen in Expanded
           BracketsScreen(league: widget.league)
        ;
      case 4:
        return RamadanCupResults(
          seasonId: selectedSeason?.id ??
              14, // Use dynamic seasonId or fallback to 14
        );
      case 5:
        return RamadanCupCalendar(
          seasonId: selectedSeason?.id ??
              14, // Use dynamic seasonId or fallback to 14
        );
      default:
        return Container(); // Fallback case
    }
  }
}
