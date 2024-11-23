import 'package:flutter/material.dart';
import 'package:flutter_tournament_bracket/flutter_tournament_bracket.dart';
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
import '../Service/data_service.dart';
import '../components/calendarContainer.dart';
import '../components/colors.dart';
import '../components/rankingContainer.dart';
import '../components/resultsContainer.dart';
import '../components/superPlayOff8Resultats.dart';
import '../components/superPlayOff8Tableau.dart';
import '../components/superPlayOffCalendar.dart';
import '../components/superPlayOffTableau.dart';
import '../models/Club.dart';
import '../models/Match.dart';
import '../models/Coupe8.dart';
import '../models/SuperPlayOff8.dart';
import '../models/TeamRanking.dart';

class PhaseDetailsScreen extends StatefulWidget {
  final String phaseName;
  final League league;
  final String trophyName;
  final Function(Match) onMatchSelected;

  const PhaseDetailsScreen(
      {super.key,
      required this.phaseName,
      required this.league,
      required this.trophyName,
      required this.onMatchSelected
      });

  @override
  _PhaseDetailsScreenState createState() => _PhaseDetailsScreenState();
}

class _PhaseDetailsScreenState extends State<PhaseDetailsScreen> {
  final DataService dataService = DataService();
  int selectedIndex = 0;
  List<Coupe8> coupes8List = []; // List for Coupe8
  List<String> years = List.generate(
      7, (index) => (19 + index).toString()); // Years from 2010 to 2024
  String selectedYear = '24'; // Default selected year
  List<Coupe8> league_superTrophies = [];
  late Coupe8? league_superTrophy = null;

  SuperPlayOff8? hannibalTrophies;

  List<Club> clubsList = [];
  List<TeamRanking> clubsListPremierePhase = [];
  SuperPlayOff? superPlayoffList;
  SuperPlayOff8? superPlayoff8List;

  Future<void> _fetchCoupes8() async {
    final fetchedCoupes8 = await dataService.fetchCoupes8();
    setState(() {
      coupes8List = fetchedCoupes8;

      // Print the names of all the fetched coupes
      for (var coupe in coupes8List) {
        print("Coupe8 name: ${coupe.season?.league?.trophy?.name}");
      }
    });
  }

  // Future<void> _fetchClubs() async {
  //   final fetchedClubs= await dataService.fetchRankingByLeague(widget.league.id!);
  //   setState(() {
  //     clubsList = fetchedClubs;
  //   });
  // }
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

  Future<void> _fetchsuperPlayoff() async {
    final fetchedClubs = await dataService.fetchSuperPlayoff(widget.league.id!);
    print("fetched clubs siperplayoff");
    setState(() {
      superPlayoffList = fetchedClubs;
    });
  }

  Future<void> _fetchsuperPlayoff8() async {
    final fetchedClubs =
        await dataService.fetchSuperPlayoff8(widget.league.id!);
    print("fetched clubs siperplayoff");
    setState(() {
      superPlayoff8List = fetchedClubs;
    });
  }

  Future<void> _fetchHannibal() async {
    final fetchedClubs =
        await dataService.league_super_trophies(widget.league.id!);
    print("fetched clubs siperplayoff");
    setState(() {
      hannibalTrophies = fetchedClubs;
    });
  }

  Future<void> league_super_trophies() async {
    // Fetch the super trophies
    final fetchedSuperTrophies = await dataService.league_super_trophies8();
    print("Fetched clubs from PremierePhase");

    try {
      // Get the first trophy that matches the league ID
      final selectedTrophy = fetchedSuperTrophies.firstWhere((trophy) {
        return trophy.season?.league?.id == widget.league.id;
      });

      // If found, update your state
      setState(() {
        league_superTrophy =
            selectedTrophy; // Store the single trophy in your state variable
      });
    } catch (e) {
      // Handle the case where no trophy is found
      print("No trophy found for the league ID ${widget.league.id}");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchClubsByPremierePhase();
    _fetchsuperPlayoff();
    _fetchCoupes8(); // Fetch Coupes8
    _fetchsuperPlayoff8();
    _fetchHannibal();
    // _fetchClubs();
    if (this.widget.phaseName == "SUPER PLAY-OFF") {
      selectedIndex = 3; // or whatever index you need
    } else if (this.widget.phaseName == "TROPHÉE HANNIBAL") {
      selectedIndex = 6; // assign the corresponding index
    } else {
      selectedIndex = 0; // default index
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Coupe8> filteredCoupes8 = coupes8List
        .where((coupe8) =>
            coupe8.season!.league?.trophy!.name!.toUpperCase() ==
            widget.trophyName.toUpperCase())
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
                    ),
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
                                ),
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
                                  widget.trophyName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                    height:
                                        4), // Space between league name and trophy name
                                Text(
                                  widget.league.name!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                    height:
                                        4), // Space between league name and trophy name
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
                                    // DropdownButton for Year Selection
                                    // Container(
                                    //   padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    //   width: 50,
                                    //   height: 35,
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.transparent,
                                    //     borderRadius: BorderRadius.circular(4.0),
                                    //     border: Border.all(color: Colors.grey, width: 1),
                                    //
                                    //   ),
                                    //   child: DropdownButton<String>(
                                    //     value: selectedYear,
                                    //     icon: Icon(Icons.arrow_drop_down),
                                    //     underline: Container(),
                                    //     onChanged: (String? newValue) {
                                    //       setState(() {
                                    //         selectedYear = newValue!;
                                    //       });
                                    //     },
                                    //     items: years.map<DropdownMenuItem<String>>((String year) {
                                    //       return DropdownMenuItem<String>(
                                    //         value: year,
                                    //         child: Text(year, style: TextStyle(fontSize: 12, color: Colors.black)),
                                    //       );
                                    //     }).toList(),
                                    //   ),
                                    // )
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
                            const SizedBox(width: 20), // Space between items
                            _buildMenuItem('RESULTATS', 1),
                            const SizedBox(width: 20), // Space between items
                            _buildMenuItem('CALENDRIER', 2),
                          ],
                          if (this.widget.phaseName == "SUPER PLAY-OFF") ...[
                            _buildMenuItem('TABLEAU', 3),
                            const SizedBox(width: 20),
                            _buildMenuItem('RESULTATS', 4),
                            const SizedBox(width: 20),
                            _buildMenuItem('CALENDRIER', 5),
                          ],
                          if (this.widget.phaseName == "TROPHÉE HANNIBAL") ...[
                            _buildMenuItem('TABLEAU', 6),
                            const SizedBox(width: 20),
                            _buildMenuItem('RESULTATS', 7),
                            const SizedBox(width: 20),
                            _buildMenuItem('CALENDRIER', 8),
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
                width: MediaQuery.of(context).size.width,
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
        return PremierePhaseRankingScreen(
          clubs: clubsListPremierePhase,
        ); // Display RankingScreen
      case 1:
        return PremierePhaseResultsScreen(
            league: widget.league, onMatchSelected: widget.onMatchSelected); // Display ResultsScreen
      case 2:
        return PremierePhaseCalendarScreen(
            league: widget.league.id!, onMatchSelected: widget.onMatchSelected,); // Display CalendarScreen
      case 3:
        if (widget.league.id == 5) {
          return SuperPlayOff8Tableau(playOff: widget.league);
        }
        // Ensure superPlayoffList is not null
        return SuperPlayOffTableau(playOff: widget.league);
      case 4:
        if (widget.league.id == 5) {
          if (superPlayoff8List != null) {
            return Superplayoff8resultat(
              superPlayOffData: superPlayoff8List!,
            );
          }
          return Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          ));
        }
        if (superPlayoffList != null) {
          return Superplayoffresultat(
            superPlayOffData: superPlayoffList!,
          );
        } else {
          return Center(
              child: CircularProgressIndicator()); // or any placeholder widget
        }

      case 5:
        if (widget.league.id == 5) {
          if (superPlayoff8List != null) {
            return SuperPlayoff8Calendar(
              superPlayOff: superPlayoff8List!,
            );
          }
          return Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          ));
        }
        if (superPlayoffList != null) {
          return SuperPlayoffCalendar(
            superPlayOff: superPlayoffList!,
          );
        } else {
          return Center(
              child: CircularProgressIndicator()); // or any placeholder widget
        }

      case 6:
        if (widget.league.id == 5) {

            return Tropheehannibalveterantableau(
              superPlayOff8: hannibalTrophies,
            );


        }
        return Tropheehannibaltableau(coupe8: league_superTrophy);
      case 7:
        if (widget.league.id == 5) {
          if (hannibalTrophies != null) {
            return TropheehannibalresultatsVeteran(coupe:hannibalTrophies );
          }
          return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ));
        }
        if (league_superTrophy != null) {
         return Tropheehannibalresultats(coupe: league_superTrophy);
        } else {
          return Center(
              child: CircularProgressIndicator()); // or any placeholder widget
        }
      case 8:
        if (widget.league.id == 5) {
          if (hannibalTrophies != null) {
            return TropheehannibalcalendarVeteran(coupe: hannibalTrophies);
          }
          return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ));
        }
        if (league_superTrophy != null) {
          return Tropheehannibalcalendar(coupe: league_superTrophy);
        } else {
          return Center(
              child: CircularProgressIndicator()); // or any placeholder widget
        }
      default:
        return Container(); // Fallback case
    }
  }
}
