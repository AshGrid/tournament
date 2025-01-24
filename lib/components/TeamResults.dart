import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';
import '../Service/data_service.dart';
import '../components/LeagueComponent.dart';
import '../models/Club.dart';
import '../models/MatchEvent.dart';
import '../models/Team.dart';
import '../models/League.dart';
import '../models/Match.dart';
import '../models/Player.dart';
import 'TeamLeagueComponent.dart';
import 'match_item.dart';
import 'match_item_live.dart';

class TeamResults extends StatefulWidget {
  final Function(Match) onMatchSelected;
  final Club team;

  const TeamResults({Key? key, required this.onMatchSelected,required this.team}) : super(key: key);

  @override
  _TeamResultsState createState() => _TeamResultsState();
}

class _TeamResultsState extends State<TeamResults> {
  final DataService dataService = DataService();
  List<Match> matches = []; // List of all matches

  bool isMatchesLoading = true; // Loading state for matches

  // Number of days to display
  int displayedDays = 2;

  @override
  void initState() {
    super.initState();
    _fetchMatches();
  }

  Future<void> _fetchMatches() async {
    try {
      // Fetch matches from the service
      final fetchedUpcomingMatches = await dataService.fetchPlayedMatches();

      // Filter the matches by teamId
      final filteredMatches = fetchedUpcomingMatches.where((match) {
        return match.home!.id == widget.team.id || match.away!.id == widget.team.id;
      }).toList();

      setState(() {
        matches = filteredMatches; // Set only the filtered matches
        isMatchesLoading = false;
      });
    } catch (error) {
      setState(() {
        isMatchesLoading = false;
      });
    }
  }

  // Grouping matches into days (journées)

  @override
  Widget build(BuildContext context) {
    if (isMatchesLoading) {
      return Center(child: CircularProgressIndicator(color: Colors.white,));
    }

    return Container(
      child: Column(
        children: [
          // Display each day and its matches


          // List of matches for the current day
          Container(
            height: (matches.length ?? 0) * 131.0 , // Adjust the height as needed
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(bottom: 0),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: matches.length ?? 0, // Safeguard against null
              itemBuilder: (context, index) {

                if ( matches.isEmpty) {
                  return Container(); // Return an empty container if no matches
                }
                final match = matches[index];
                return GestureDetector(
                  onTap: () {

                      widget.onMatchSelected!(match);

                  },
                  child: MatchItemLive(
                    match: match,
                    backgroundColor: index.isEven ? Colors.transparent : Colors.transparent,
                    isLastItem: index == matches.length - 1, // Check if it's the last item
                    isFirstItem: index == 0,
                  ),

                );
              },
            ),
          ),

          // "See More" button

          // Image slider at the bottom

        ],
      ),
    );
  }
}

