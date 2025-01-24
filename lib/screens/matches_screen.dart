import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';
import 'package:untitled/components/Coupe8Component.dart';
import '../Service/data_service.dart';
import '../components/CoupeComponent.dart';
import '../components/LeagueComponent.dart';
import '../components/colors.dart';
import '../components/match_item.dart';
import '../components/match_item_live.dart';
import '../models/Coupe.dart';
import '../models/Coupe8.dart';
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

  List<Match> matches = [];
  bool isTrophiesLoading = true;
  bool isMatchesLoading = true;
  bool isLeaguesLoading = true;
  bool isDaysLoading = true;
  List<DateTime> dayss = [];
  List<Coupe> coupesList = [];
  List<Coupe8> coupes8List = [];

  Future<void> _fetchTrophies() async {
    try {
      final fetchedTrophies = await dataService.fetchTrophies();
      setState(() {
        trophiesList =
        fetchedTrophies..sort((a, b) => a.name!.compareTo(b.name!));
        isTrophiesLoading = false;
      });
    } catch (error) {
      setState(() {
        isTrophiesLoading = false;
      });
    }
  }

  Future<void> _fetchCoupes() async {
    final fetchedCoupes = await dataService.fetchCoupes();
    setState(() {
      coupesList = fetchedCoupes;
    });
  }

  Future<void> _fetchCoupes8() async {
    final fetchedCoupes8 = await dataService.fetchCoupes8();
    setState(() {
      coupes8List = fetchedCoupes8;
    });
  }

  Future<void> _fetchDays() async {
    try {
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
      setState(() {
        leaguesList = fetchedLeagues;
        isLeaguesLoading = false;
      });
    } catch (error) {
      setState(() {
        isLeaguesLoading = false;
      });
    }
  }

  Future<void> _fetchMatches() async {
    try {

      final fetchedUpcomingMatches = await dataService.fetchUpcomingMatches();
      setState(() {
        matches = fetchedUpcomingMatches;
        isMatchesLoading = false;
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
    _fetchLeagues();
    _fetchDays();
    _fetchCoupes();
    _fetchCoupes8();
  }


  @override
  @override
  Widget build(BuildContext context) {
    bool isLoading = isTrophiesLoading || isMatchesLoading || isLeaguesLoading || isDaysLoading;
    DateTime selectedDate = (dayss.isNotEmpty) ? dayss[selectedDayIndex] : DateTime.now();

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
                        selectedDayIndex = index;
                        // Refresh the components based on the selected date
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

        // Vertically scrollable container for leagues, coupes, and coupe 8
        Expanded(
          child: isLoading
              ? Center(child: CircularProgressIndicator(color: Colors.white))
              : ListView.builder(
            itemCount: trophiesList.length,
            itemBuilder: (context, trophyIndex) {
              final trophy = trophiesList[trophyIndex];

              // Filter leagues, coupes, and coupe8 by trophy
              final filteredLeagues = leaguesList.where((league) => league.trophy?.id == trophy.id).toList();
              final filteredCoupes = coupesList.where((coupe) => coupe.season!.league?.trophy?.id == trophy.id).toList();
              final filteredCoupes8 = coupes8List.where((coupe8) => coupe8.season!.league?.trophy?.id == trophy.id).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTrophyHeader(trophy),

                  // Display leagues for the trophy
                  if (filteredLeagues.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 8.0, bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: filteredLeagues.map((league) {
                          return LeagueComponent(
                            league: league,
                            onMatchSelected: widget.onMatchSelected,
                            date: selectedDate, // Pass the selected date here
                          );
                        }).toList(),
                      ),
                    ),

                  // Display Coupes for the trophy
                  if (filteredCoupes.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 8.0, bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: filteredCoupes.map((coupe) {
                          return CoupeComponent(
                            coupe: coupe,
                            onMatchSelected: widget.onMatchSelected,
                            date: selectedDate, // Pass the selected date here
                          );
                        }).toList(),
                      ),
                    ),

                  // Display Coupe 8s for the trophy
                  if (filteredCoupes8.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 8.0, bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: filteredCoupes8.map((coupe8) {
                          return Coupe8Component(
                            coupe8: coupe8,
                            onMatchSelected: widget.onMatchSelected,
                            date: selectedDate, // Pass the selected date here
                          );
                        }).toList(),
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



  // Widget to build trophy header
  Widget _buildTrophyHeader(Trophy trophy) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bottomSheetItem,
        border: Border.symmetric(
          horizontal: BorderSide(color: Color(0xFFFFFFFF), width: 2),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
            vertical: 8.0, horizontal: 8.0),
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
                color: Colors.black,
                blurRadius: 1.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build league matches


// Widget to build coupe matches

}
  // Widget to build coupe 8 matches

