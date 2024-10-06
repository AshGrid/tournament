import 'package:flutter/material.dart';


import 'package:untitled/components/superPlayOffCalendar.dart';
import 'package:untitled/components/superPlayOffResultats.dart';
import 'package:untitled/components/tropheeHannibalCalendar.dart';
import 'package:untitled/components/tropheeHannibalResultats.dart';
import 'package:untitled/components/tropheeHannibalTableau.dart';
import 'package:untitled/models/league.dart';
import '../components/calendarContainer.dart';
import '../components/colors.dart';
import '../components/rankingContainer.dart';
import '../components/resultsContainer.dart';
import '../components/superPlayOffTableau.dart';

class PhaseDetailsScreen extends StatefulWidget {
  final String phaseName;
  final League league;
  final String trophyName;

  const PhaseDetailsScreen({super.key, required this.phaseName, required this.league, required this.trophyName});

  @override
  _PhaseDetailsScreenState createState() => _PhaseDetailsScreenState();
}

class _PhaseDetailsScreenState extends State<PhaseDetailsScreen> {


      // Add more quarterfinal matches here...






  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    if (this.widget.phaseName == "SUPER PLAY-OFF") {
      selectedIndex = 3; // or whatever index you need
    } else if (this.widget.phaseName == "TROPHEE HANNIBAL") {
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
                      color: Colors.transparent.withOpacity(0.1),
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
                                  'assets/images/${widget.league.leagueName.toUpperCase()}.png',
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
                                  widget.league.leagueName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4), // Space between league name and trophy name
                                Text(
                                  widget.phaseName,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
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
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                          if (this.widget.phaseName == "TROPHEE HANNIBAL") ...[
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
              width: title == 'CALENDRIER' ? 100 : title == 'RESULTATS' ? 80 : title == 'TABLEAU' ? 80 : 100,
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
        return PremierePhaseRankingScreen(); // Display RankingScreen
      case 1:
        return PremierePhaseResultsScreen(); // Display ResultsScreen
      case 2:
        return PremierePhaseCalendarScreen(); // Display CalendarScreen
      case 3:
        return SuperPlayOffTableau();
      case 4:
        return Superplayoffresultats();
      case 5:
        return Superplayoffcalendar();
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
