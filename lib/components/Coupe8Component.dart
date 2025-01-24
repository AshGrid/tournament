import 'package:flutter/material.dart';
import 'package:untitled/screens/match_details.dart';
import '../models/Coupe8.dart'; // Import the Coupe8 model
import '../models/Match.dart'; // Import the Match model
import 'match_item_live.dart'; // Import the MatchItemLive component
import 'package:untitled/components/colors.dart'; // Ensure AppColors is correctly imported

class Coupe8Component extends StatefulWidget {
  final Coupe8 coupe8;
  final DateTime date;
  final Function(Match) onMatchSelected;

  const Coupe8Component({
    Key? key,
    required this.coupe8,
    required this.onMatchSelected,
    required this.date,
  }) : super(key: key);

  @override
  _Coupe8ComponentState createState() => _Coupe8ComponentState();
}

class _Coupe8ComponentState extends State<Coupe8Component> {
  List<Match> matchesList = [];

  @override
  void initState() {
    super.initState();
    _fetchMatches();
  }

  @override
  void didUpdateWidget(Coupe8Component oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.date != widget.date) {
      _fetchMatches();
    }
  }

  // Collect matches from the coupe8 rounds and filter by date
  void _fetchMatches() {
    List<Match?> rounds = [
      widget.coupe8.quarter_final_1,
      widget.coupe8.quarter_final_2,
      widget.coupe8.quarter_final_3,
      widget.coupe8.quarter_final_4,
      widget.coupe8.semi_final_1,
      widget.coupe8.semi_final_2,
      widget.coupe8.finalMatch,
    ];

    // Filter out null rounds and matches not on the specified date
    setState(() {
      matchesList = rounds.where((match) {
        if (match == null) return false;
        // Check if the match date matches the selected date
        return _isMatchOnSelectedDate(match.date);
      }).cast<Match>().toList();
    });
  }

  // Helper method to check if the match date is the same as the selected date
  bool _isMatchOnSelectedDate(DateTime? matchDateTime) {
    if (matchDateTime == null) return false;
    return matchDateTime.year == widget.date.year &&
        matchDateTime.month == widget.date.month &&
        matchDateTime.day == widget.date.day;
  }

  @override
  Widget build(BuildContext context) {
    // Sort matches to prioritize live matches
    List<Match> sortedMatches = List.from(matchesList);
    sortedMatches.sort((a, b) {
      bool aIsLive = a.status!.toLowerCase() == 'live';
      bool bIsLive = b.status!.toLowerCase() == 'live';

      if (aIsLive && !bIsLive) return -1;
      if (!aIsLive && bIsLive) return 1;
      return 0;
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
                width: 40,
                height: 40,

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Image.asset(
                      "assets/images/${widget.coupe8.name!.toUpperCase()}.png",
                      width: 55,
                      height: 55,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                widget.coupe8.name!.toUpperCase(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        // Matches List
        Column(
          children: List.generate(
            sortedMatches.length,
                (index) {
              final match = sortedMatches[index];
              return GestureDetector(
                onTap: () {
                  widget.onMatchSelected(match);
                },
                child: MatchItemLive(
                  match: match,
                  backgroundColor: index.isEven ? Colors.transparent : Colors.transparent,
                  isLastItem: index == sortedMatches.length - 1,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
