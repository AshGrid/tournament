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
  final Function(Match) onMatchSelected;

  const LeagueComponent({Key? key, required this.league, required this.onMatchSelected}) : super(key: key);

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
    final fetchedMatches = await dataService.fetchPlayedMatches();
    setState(() {
      matchesList = fetchedMatches;

    });
  }


  void addMatchEvents(Match match) {
    // Your logic for adding match events (if needed)
  }

  @override
  Widget build(BuildContext context) {
    // Sort matches to put live matches first
    List<Match> sortedMatches = List.from(matchesList);
    sortedMatches.sort((a, b) {
      // Check if the match is live or not
      bool aIsLive = a.status!.toLowerCase() == 'live';
      bool bIsLive = b.status!.toLowerCase() == 'live';

      // Prioritize live matches
      if (aIsLive && !bIsLive) return -1;
      if (!aIsLive && bIsLive) return 1;

      // Maintain the original order if both matches have the same status
      return 0;
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // League Name and Logo Container
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.leagueComponent,
            border: Border(
              top: BorderSide(color: Colors.white),
              bottom: BorderSide(color: Colors.white),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              // Container for the League Logo with border and shadow
              Container(
                width: 65, // Adjust the width and height as needed
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: AppColors.teamLogoBorder, width: 1), // Add border to the container
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.teamLogoShadow, // Shadow color
                      offset: Offset(2, 4), // Shadow position
                      blurRadius: 4, // How blurry the shadow is
                    ),
                  ],
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
                  isLastItem: index == sortedMatches.length - 1, // Check if it's the last item
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
