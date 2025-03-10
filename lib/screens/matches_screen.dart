import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';
import 'package:untitled/components/Coupe8Component.dart';
import '../Service/data_service.dart';
import '../components/CoupeComponent.dart';
import '../components/LeagueComponent.dart';
import '../components/colors.dart';
import '../components/match_item_live.dart';
import '../models/Coupe.dart';
import '../models/Coupe8.dart';
import '../models/League.dart';
import '../models/Match.dart';
import '../models/Trophy.dart';

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
  List<Coupe> coupesList = [];
  List<Coupe8> coupes8List = [];
  List<DateTime> dayss = [];

  bool isTrophiesLoading = true;
  bool isMatchesLoading = true;
  bool isLeaguesLoading = true;
  bool isDaysLoading = true;

  Future<void> _fetchData() async {
    try {
      final fetchedTrophies = await dataService.fetchTrophies();
      final fetchedLeagues = await dataService.fetchLeagues();
      final fetchedMatches = await dataService.fetchUpcomingMatches();
      final fetchedDays = await dataService.fetchUpcomingMatchDates();
      final fetchedCoupes = await dataService.fetchCoupes();
      final fetchedCoupes8 = await dataService.fetchCoupes8();

      setState(() {
        trophiesList = fetchedTrophies..sort((a, b) => a.name!.compareTo(b.name!));
        leaguesList = fetchedLeagues;
        matches = fetchedMatches;
        coupesList = fetchedCoupes;
        coupes8List = fetchedCoupes8;
        if (fetchedDays.isNotEmpty) dayss = fetchedDays;

        isTrophiesLoading = false;
        isMatchesLoading = false;
        isLeaguesLoading = false;
        isDaysLoading = false;
      });
    } catch (error) {
      setState(() {
        isTrophiesLoading = false;
        isMatchesLoading = false;
        isLeaguesLoading = false;
        isDaysLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = isTrophiesLoading || isMatchesLoading || isLeaguesLoading || isDaysLoading;
    DateTime selectedDate = (dayss.isNotEmpty) ? dayss[selectedDayIndex] : DateTime.now();

    return Column(
      children: [
        // Date selector
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
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${day.day}/${day.month}/${day.year}",
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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

        // Main content
        Expanded(
          child: isLoading
              ? const Center(child: CircularProgressIndicator(color: Colors.white))
              : ListView.builder(
            itemCount: trophiesList.length,
            itemBuilder: (context, trophyIndex) {
              final trophy = trophiesList[trophyIndex];

              // Filter leagues, coupes, and coupe8 by trophy
              final filteredLeagues = leaguesList.where((league) => league.trophy?.id == trophy.id).toList();
              final filteredCoupes = coupesList.where((coupe) => coupe.season!.league?.trophy?.id == trophy.id).toList();
              final filteredCoupes8 = coupes8List.where((coupe8) => coupe8.season!.league?.trophy?.id == trophy.id).toList();
              final filteredMatches = matches.where((match) => match.trophy?.id == trophy.id).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTrophyHeader(trophy),

                  // Display leagues
                  if (filteredLeagues.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: filteredLeagues.map((league) {
                          return LeagueComponent(
                            league: league,
                            onMatchSelected: widget.onMatchSelected,
                            date: selectedDate,
                          );
                        }).toList(),
                      ),
                    ),

                  // Display Coupes
                  if (filteredCoupes.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: filteredCoupes.map((coupe) {
                          return CoupeComponent(
                            coupe: coupe,
                            onMatchSelected: widget.onMatchSelected,
                            date: selectedDate,
                          );
                        }).toList(),
                      ),
                    ),

                  // Display Coupe 8s
                  if (filteredCoupes8.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: filteredCoupes8.map((coupe8) {
                          return Coupe8Component(
                            coupe8: coupe8,
                            onMatchSelected: widget.onMatchSelected,
                            date: selectedDate,
                          );
                        }).toList(),
                      ),
                    ),

                  // Special Case: Ramadan Cup Matches
                  // Special Case: Ramadan Cup Matches
                  if (trophy.name?.toLowerCase() == "ramadan cup" && filteredMatches.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: filteredMatches.where((match) {
                          // Compare match date with selectedDate
                          return match.date?.year == selectedDate.year &&
                              match.date?.month == selectedDate.month &&
                              match.date?.day == selectedDate.day;
                        }).toList().map((match) {
                          return MatchItemLive(
                            match: match,
                            backgroundColor: Colors.transparent,
                            isFirstItem: match == filteredMatches.first,
                            isLastItem: match == filteredMatches.last,
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

  // Trophy Header Widget
  Widget _buildTrophyHeader(Trophy trophy) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bottomSheetItem,
        border: Border.symmetric(horizontal: const BorderSide(color: Color(0xFFFFFFFF), width: 2)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        leading: Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: AppColors.bottomSheetLogo, width: 1.0),
          ),
          child: Image.asset(
            'assets/images/${trophy.name?.toUpperCase() ?? 'default'}.png',
            fit: BoxFit.scaleDown,
          ),
        ),
        title: Text(
          trophy.name?.toUpperCase() ?? 'UNKNOWN TROPHY',
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
