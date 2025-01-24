import 'package:flutter/material.dart';
import 'package:untitled/components/matchFormation.dart';
import 'package:untitled/components/matchResume.dart';
import 'package:untitled/components/rankingContainer.dart';
import 'package:untitled/components/scoreBoardItem.dart';
import 'package:untitled/models/Club.dart';



import 'package:untitled/models/Match.dart';
import '../Service/data_service.dart';
import '../components/calendarContainer.dart';
import '../components/colors.dart';

import '../components/matchStats.dart';
import '../components/resultsContainer.dart';
import '../models/Team.dart';
import '../models/TeamRanking.dart';


class MatchDetailsPage extends StatefulWidget {
 final Match match;
 final Function(Club) onTeamSelected;
  const MatchDetailsPage({super.key, required this.match, required this.onTeamSelected});

  @override
  _MatchDetailsPageState createState() => _MatchDetailsPageState();
}

class _MatchDetailsPageState extends State<MatchDetailsPage> {
  int selectedIndex = 0;
  List<TeamRanking> clubsList= [];
  List<Club> clubs=[];

  final DataService dataService = DataService();

  @override
  void initState() {
    super.initState();

    _fetchClubs();
    _fetchClubsList();

  }

  Future<void> _fetchClubs() async {
    try {
      final fetchedClubs = await dataService.fetchRankingByLeague(widget.match.home!.league!);
      print("fetched clubs premirephase by league id");

      // Sort the clubs by teamranking.points in descending order
      fetchedClubs.sort((a, b) => b.points!.compareTo(a.points!));

      setState(() {
        clubsList = fetchedClubs; // Use the sorted list
      });

      print(clubsList); // Log the sorted clubs
    } catch (error) {
      print('Error fetching clubs: $error');
      // Handle error if necessary
    }
  }
  Future<void> _fetchClubsList() async {
    final fetchedClubs= await dataService.fetchClubs();
    final filteredClubs = fetchedClubs.where((club) {
      return club.league == widget.match.home!.league; // Adjust this based on your club and match model
    }).toList();
    setState(() {
      clubs = filteredClubs;
    });
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
                  color: Colors.white,
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
                      padding: const EdgeInsets.all(6.0),
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
                            child: ScoreboardItem(match: this.widget.match, onTeamSelected: widget.onTeamSelected,),
                          ),



                          // League Name

                        ],
                      ),
                    ),


                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [


                            _buildMenuItem('RÉSUMÉ', 0),

                            _buildMenuItem('FORMATION', 1),

                            _buildMenuItem('CLASSEMENT', 2),

                          _buildMenuItem('STATISTIQUE', 3),


                        ],
                      ),
                    ),

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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13,
              fontFamily: "oswald",
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          // Underline only for the selected item
          if (selectedIndex == index)
            Container(
              height: 2,
              width: title == "FORMATION" ? 70: title =="CLASSEMENT"? 75 : title =="STATISTIQUE"? 75 : 50,
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
        return PremierePhaseRankingScreen(clubs: clubsList,); // Display CalendarScreen
      case 3:
        return MatchStats(match: match,); // Display CalendarScreen

      default:
        return Container(); // Fallback case
    }
  }
}
