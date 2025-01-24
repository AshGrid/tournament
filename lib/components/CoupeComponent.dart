import 'package:flutter/material.dart';
import 'package:untitled/screens/match_details.dart';
import '../Service/data_service.dart';
import '../models/Coupe.dart';
import '../models/MatchEvent.dart';
import '../models/Team.dart';
import '../models/Match.dart';
import '../models/League.dart'; // Import your League model
import 'match_item.dart'; // Import the MatchItem component
import 'match_item_live.dart'; // Import the MatchItemLive component
import 'package:untitled/components/colors.dart'; // Ensure AppColors is correctly imported

class CoupeComponent extends StatefulWidget {
  final Coupe coupe;
  final DateTime date;
  final Function(Match) onMatchSelected;

  const CoupeComponent({Key? key, required this.coupe, required this.date, required this.onMatchSelected}) : super(key: key);

  @override
  _CoupeComponentState createState() => _CoupeComponentState();
}

class _CoupeComponentState extends State<CoupeComponent> {
  List<Match> matchesList = [];

  @override
  void initState() {
    super.initState();
    _fetchMatches();
  }
  @override
  void didUpdateWidget(CoupeComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.date != widget.date) {
      _fetchMatches();
    }
  }
  // Collect matches from the coupe rounds and filter by date
  void _fetchMatches() {
    List<Match?> rounds = [
      widget.coupe.round_1,
      widget.coupe.round_2,
      widget.coupe.round_3,
      widget.coupe.round_4,
      widget.coupe.round_5,
      widget.coupe.round_6,
      widget.coupe.round_7,
      widget.coupe.round_8,
      widget.coupe.quarter_final_1,
      widget.coupe.quarter_final_2,
      widget.coupe.quarter_final_3,
      widget.coupe.quarter_final_4,
      widget.coupe.semi_final_1,
      widget.coupe.semi_final_2,
      widget.coupe.finalmatch,
    ];

    // Filter out null rounds and update the matches list
    setState(() {
      matchesList = rounds.where((match) => match != null).cast<Match>().toList();
      // Filter matches based on the specified date

    });
  }

  @override
  Widget build(BuildContext context) {
    // Sort matches to put live matches first

    matchesList = matchesList.where((match) {
      // Assuming match.date is of type DateTime
      final matchDate = match.date;
      return matchDate != null &&
          matchDate.day == widget.date.day &&
          matchDate.month == widget.date.month &&
          matchDate.year == widget.date.year;
    }).toList();

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
                      "assets/images/${widget.coupe.name!.toUpperCase()}.png",
                      width: 55,
                      height: 55,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                widget.coupe.name!.toUpperCase(),
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
                  isLastItem: index == matchesList.length - 1,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
