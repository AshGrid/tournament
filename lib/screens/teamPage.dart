import 'package:flutter/material.dart';
import 'package:untitled/components/TeamPlayers.dart';
import 'package:untitled/components/TeamResults.dart';


import 'package:untitled/components/superPlayOffCalendar.dart';
import 'package:untitled/components/superPlayOffResultats.dart';
import 'package:untitled/components/tropheeHannibalCalendar.dart';
import 'package:untitled/components/tropheeHannibalResultats.dart';
import 'package:untitled/components/tropheeHannibalTableau.dart';
import 'package:untitled/models/League.dart';
import 'package:untitled/models/TeamRanking.dart';
import 'package:untitled/screens/matches_screen.dart';
import '../Service/data_service.dart';
import '../components/TeamLeagueComponent.dart';
import '../components/calendarContainer.dart';
import '../components/colors.dart';
import '../components/rankingContainer.dart';
import '../components/resultsContainer.dart';
import '../components/superPlayOffTableau.dart';
import '../models/Club.dart';
import '../models/Player.dart';
import '../models/Team.dart';

class TeamPage extends StatefulWidget {
  final Club team;
  final Function(Player) onPlayerSelected;

  const TeamPage({super.key, required this.team, required this.onPlayerSelected});

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {


  int selectedIndex = 0;

  List<TeamRanking> clubsList= [];

  final DataService dataService = DataService();



  Future<void> _fetchClubs() async {
    final fetchedClubs= await dataService.fetchRankingByLeague(widget.team.league!);
    setState(() {
      clubsList = fetchedClubs;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchClubs();
     selectedIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: AppColors.backgroundColor
        ),
        child: CustomScrollView(
          slivers: [
            // Phase Details Header
            SliverToBoxAdapter(
              child: Container(
                height: 170,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 12,right: 12,top: 12,bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                                child: Image.network(
                                  '${widget.team.logo}',
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
                                  widget.team.name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4), // Space between league name and trophy name
                                Text(
                                  widget.team.name!,
                                  style: TextStyle(
                                    fontSize: 10,
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
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildMenuItem('RESULTATS', 0),

                            _buildMenuItem('CLASSEMENT', 1),


                            _buildMenuItem('CALENDRIER', 2),


                          _buildMenuItem('EFFECTIF', 3),


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
                padding:  selectedIndex == 1 ? EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0): EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
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
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          // Underline only for the selected item
          if (selectedIndex == index)
            Container(
              height: 2,
              width: title == 'CALENDRIER' ? 70 : title == 'RESULTATS' ? 70 : title == 'CLASSEMENT' ? 80 : 50,
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
        return TeamResults(club: widget.team); // Display RankingScreen
       case 1:
         return PremierePhaseRankingScreen(clubs: clubsList); // Display ResultsScreen
      case 2:
        return PremierePhaseCalendarScreen(league: widget.team.league!,); // Display CalendarScreen
      case 3:
        return TeamPlayers(team: widget.team, onPlayerSelected: widget.onPlayerSelected,);


      default:
        return Container(); // Fallback case
    }
  }
}
