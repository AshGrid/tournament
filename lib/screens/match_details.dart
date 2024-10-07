import 'package:flutter/material.dart';
import 'package:untitled/components/matchFormation.dart';
import 'package:untitled/components/matchResume.dart';
import 'package:untitled/components/scoreBoardItem.dart';



import 'package:untitled/models/match.dart';
import '../components/calendarContainer.dart';
import '../components/colors.dart';

import '../components/resultsContainer.dart';


class MatchDetailsPage extends StatefulWidget {
 final Match match;

  const MatchDetailsPage({super.key, required this.match});

  @override
  _MatchDetailsPageState createState() => _MatchDetailsPageState();
}

class _MatchDetailsPageState extends State<MatchDetailsPage> {


  // Add more quarterfinal matches here...






  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

      selectedIndex = 0; // default index

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
                          Container(
                            child: ScoreboardItem(match: this.widget.match),
                          ),


                          const SizedBox(width: 10),
                          // League Name
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                const SizedBox(height: 4), // Space between league name and trophy name

                                const SizedBox(height: 4), // Space between league name and trophy name

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

                            _buildMenuItem('RÉSUMÉ', 0),
                            const SizedBox(width: 20), // Space between items
                            _buildMenuItem('FORMATION', 1),
                            const SizedBox(width: 20), // Space between items
                            _buildMenuItem('CLASSEMENT', 2),


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
                child: _buildSelectedContent(this.widget.match),
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
              width: title == 'RÉSUMÉ' ? 100 : title == 'FORMATION' ? 80 : title == 'CLASSEMENT' ? 80 : 100,
              color: Colors.black,
            ),
        ],
      ),
    );
  }

  // Method to build the selected content
  Widget _buildSelectedContent(Match match) {
    switch (selectedIndex) {
      case 0:
        return MatchResume(match: match ); // Display RankingScreen
      case 1:
        return MatchFormation(match: match); // Display ResultsScreen
      case 2:
        return PremierePhaseCalendarScreen(); // Display CalendarScreen

      default:
        return Container(); // Fallback case
    }
  }
}
