import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Service/data_service.dart';
import '../components/matchItemFavorite.dart';
import '../models/Match.dart';

class FavoriteScreen extends StatefulWidget {
  final Function(Match) onMatchSelected;
  const FavoriteScreen({Key? key, required this.onMatchSelected}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final DataService dataService = DataService();
  List<Match> matchesList = [];
  bool isLoading = true;
  bool isDaysLoading = true;
  List<DateTime> dayss = [];
  int selectedDayIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchMatches();
    _fetchDays();
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

  Future<List<int>> _loadFavoriteTeams() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteTeams = prefs.getStringList('favoriteTeams') ?? [];
    return favoriteTeams.map((id) => int.parse(id)).toList();
  }

  Future<void> _fetchMatches() async {
    setState(() {
      isLoading = true;
    });

    try {
      final fetchedMatches = await dataService.fetchUpcomingMatches();
      final favoriteTeamIds = await _loadFavoriteTeams();

      // Filter matches based on favorite teams from SharedPreferences
      matchesList = fetchedMatches.where((match) {
        return favoriteTeamIds.contains(match.home!.id) ||
            favoriteTeamIds.contains(match.away!.id);
      }).toList();
    } catch (e) {
      print('Error fetching matches: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isAllLoading = isLoading || isDaysLoading;
    DateTime selectedDate = (dayss.isNotEmpty) ? dayss[selectedDayIndex] : DateTime.now();

    // Filter matches based on the selected date
    List<Match> filteredMatches = matchesList.where((match) {
      if (match.date == null) return false;
      return match.date!.year == selectedDate.year &&
          match.date!.month == selectedDate.month &&
          match.date!.day == selectedDate.day;
    }).toList();

    return Column(
      children: [
        if (isAllLoading)
          const Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )

        else
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
        if (filteredMatches.isEmpty)
           Expanded(
            child: Container(),
          )
        else Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8),
            itemCount: filteredMatches.length,
            itemBuilder: (context, index) {
              final match = filteredMatches[index];
              return GestureDetector(
                onTap: () {
                  widget.onMatchSelected(match);
                },
                child: MatchItemFavorite(
                  match: match,
                  isFirstItem: index == 0,
                  isLastItem: index == filteredMatches.length - 1,
                  backgroundColor: Colors.transparent,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
