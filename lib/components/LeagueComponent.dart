import 'package:flutter/material.dart';
import 'package:untitled/screens/match_details.dart';
import '../Service/data_service.dart';
import '../models/MatchEvent.dart';
import '../models/Team.dart';
import '../models/Match.dart';
import '../models/League.dart'; // Import your League model
import 'match_item.dart'; // Import the MatchItem component
import 'match_item_live.dart'; // Import the MatchItemLive component
import 'package:untitled/components/colors.dart'; // Ensure AppColors is correctly imported

class LeagueComponent extends StatefulWidget {
  final League league;
  final DateTime date;
  final Function(Match) onMatchSelected;

  const LeagueComponent({Key? key, required this.league, required this.onMatchSelected, required this.date}) : super(key: key);

  @override
  _LeagueComponentState createState() => _LeagueComponentState();
}

class _LeagueComponentState extends State<LeagueComponent> {


  final DataService dataService = DataService();

  List<Match> matchesList = [];

  @override
  void initState() {
    super.initState();

    _fetchMatches();

  }



  Future<void> _fetchMatches() async {
    try {
      final fetchedMatches = await dataService.fetchUpcomingMatches();
      if (mounted) {
        setState(() {
          matchesList = fetchedMatches;
        });
      }
    } catch (error) {
      print("Error fetching matches: $error");
      // Optionally, handle the error further here, e.g. showing an error message in the UI
    }
  }
  @override
  void didUpdateWidget(LeagueComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.date != widget.date) {
      _fetchMatches();
    }
  }



//  match.home!.league == widget.league.id &&

  @override
  Widget build(BuildContext context) {
    // Sort matches to put live matches first
    matchesList = matchesList.where((match) {
      // Check if the match belongs to the selected league and matches the date
      bool isSameLeague = match.away!.league == widget.league.id;
      bool isSameDate = match.date != null && (
          match.date!.year == widget.date.year &&
              match.date!.month == widget.date.month &&
              match.date!.day == widget.date.day
      );
      bool isRamadanCup =  match.trophy!.name == "Ramadan Cup".toUpperCase();
      print("matches in league component");
      print(matchesList);
      return isSameLeague && isSameDate && !isRamadanCup;
    }).toList();
    matchesList.sort((a, b) {
      if (a.time == null) return 1; // Push null times to the end
      if (b.time == null) return -1;
      return a.time!.compareTo(b.time!);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // League Name and Logo Container
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              top: BorderSide(color: Colors.white,width: 0.2),
              bottom: BorderSide(color: Colors.white,width: 0.2),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              // Container for the League Logo with border and shadow
              Container(
                width: 40, // Adjust the width and height as needed
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                   // Add border to the container

                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0), // Match the border radius
                  child: FittedBox(
                    fit: BoxFit.scaleDown, // Ensure the image scales down to fit inside
                    child: Image.asset(
                      "assets/images/${widget.league.name!.toUpperCase()}.png",
                      width: 55, // Adjust the size here
                      height: 55,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                widget.league.name!.toUpperCase(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        // Matches List Container with no extra padding or spacing
        Column(
          children: List.generate(
            matchesList.length,
                (index) {
              final match = matchesList[index];
              return GestureDetector(
                onTap: () {
                  widget.onMatchSelected(match);
                },
                child: MatchItemLive(
                  match: match,
                  backgroundColor: index.isEven ? Colors.transparent : Colors.transparent,
                  isLastItem: index == matchesList.length - 1, isFirstItem: index == 0, // Check if it's the last item
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
