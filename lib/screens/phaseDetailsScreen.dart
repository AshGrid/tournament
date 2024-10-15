import 'package:flutter/material.dart';
import 'package:flutter_tournament_bracket/flutter_tournament_bracket.dart';


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
import '../components/superPlayOffCalendar.dart';
import '../components/superPlayOffTableau.dart';
import '../models/Club.dart';
import '../models/TeamRanking.dart';

class PhaseDetailsScreen extends StatefulWidget {
  final String phaseName;
  final League league;
  final String trophyName;

  const PhaseDetailsScreen({super.key, required this.phaseName, required this.league, required this.trophyName});

  @override
  _PhaseDetailsScreenState createState() => _PhaseDetailsScreenState();
}

class _PhaseDetailsScreenState extends State<PhaseDetailsScreen> {
  final DataService dataService = DataService();
  int selectedIndex = 0;

  List<String> years = List.generate(7, (index) => (19 + index).toString()); // Years from 2010 to 2024
  String selectedYear = '24'; // Default selected year




  List<Club> clubsList= [];
  List<TeamRanking> clubsListPremierePhase= [];
  SuperPlayOff? superPlayoffList;




   // Future<void> _fetchClubs() async {
   //   final fetchedClubs= await dataService.fetchRankingByLeague(widget.league.id!);
   //   setState(() {
   //     clubsList = fetchedClubs;
   //   });
   // }
  Future<void> _fetchClubsByPremierePhase() async {
    final fetchedClubs= await dataService.fetchRankingByLeague(widget.league.id!);
    print("fetched clubs premirephase");
    setState(() {
      clubsListPremierePhase = fetchedClubs;
    });
  }
  Future<void> _fetchsuperPlayoff() async {
    final fetchedClubs= await dataService.fetchSuperPlayoff(widget.league.id!);
    print("fetched clubs premirephase");
    setState(() {
      superPlayoffList = fetchedClubs;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchClubsByPremierePhase();
    _fetchsuperPlayoff();
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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundColor
        ),
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
                              border: Border.all(color: Colors.black12, width: 1),
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
                                const SizedBox(height: 4), // Space between league name and trophy name
                                Text(
                                  widget.league.name!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4), // Space between league name and trophy name
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
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      width: 50,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(4.0),
                                        border: Border.all(color: Colors.grey, width: 1),

                                      ),
                                      child: DropdownButton<String>(
                                        value: selectedYear,
                                        icon: Icon(Icons.arrow_drop_down),
                                        underline: Container(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedYear = newValue!;
                                          });
                                        },
                                        items: years.map<DropdownMenuItem<String>>((String year) {
                                          return DropdownMenuItem<String>(
                                            value: year,
                                            child: Text(year, style: TextStyle(fontSize: 12, color: Colors.black)),
                                          );
                                        }).toList(),
                                      ),
                                    )
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
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
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
         return PremierePhaseRankingScreen(clubs: clubsListPremierePhase,); // Display RankingScreen
      case 1:
        return PremierePhaseResultsScreen(league: widget.league); // Display ResultsScreen
      case 2:
        return PremierePhaseCalendarScreen(league: widget.league.id!); // Display CalendarScreen
      case 3:
      // Ensure superPlayoffList is not null
        if (superPlayoffList != null) {
          return SuperPlayOffTableau(playOff: widget.league);
        } else {
          return Center(child: CircularProgressIndicator()); // or any placeholder widget
        }
      case 4:
        if (superPlayoffList != null) {
          return Superplayoffresultat(superPlayOffData: superPlayoffList!,);
        } else {
          return Center(child: CircularProgressIndicator()); // or any placeholder widget
        }

      case 5:
        if (superPlayoffList != null) {
          return SuperPlayoffCalendar(superPlayOff: superPlayoffList!,);
        } else {
          return Center(child: CircularProgressIndicator()); // or any placeholder widget
        }

      case 6:
        return Tropheehannibaltableau();
      case 7:
        return Tropheehannibalresultats();
      case 8:
        return Tropheehannibalcalendar();
      default:
        return Container(); // Fallback case
    }
  }
}
