import 'package:flutter/material.dart';
import 'package:untitled/screens/match_details.dart';
import '../models/MatchEvent.dart';
import '../models/Team.dart';
import '../models/match.dart';
import '../models/league.dart'; // Import your League model
import 'match_item.dart'; // Import the MatchItem component
import 'match_item_live.dart'; // Import the MatchItemLive component
import 'package:untitled/components/colors.dart'; // Ensure AppColors is correctly imported

class LeagueComponent extends StatelessWidget {
  final League league;

  const LeagueComponent({Key? key, required this.league}) : super(key: key);

  void addMatchEvents(Match match) {

    match.matchEvents.addAll([
      MatchEvent(
        description: "Goal",
        time: DateTime.now().subtract(Duration(minutes: 15)),
        playerName: 'Player 1',
        assistPlayerName: 'Player 2',
        team: match.homeTeam, // Reference team1 for this event
      ),
      MatchEvent(
        description: "Yellow Card",
        time: DateTime.now().subtract(Duration(minutes: 30)),
        playerName: 'Player 3',
        team: match.awayTeam, // Reference team2 for this event
      ),
      MatchEvent(
        description: "Goal",
        time: DateTime.now().subtract(Duration(minutes: 45)),
        playerName: 'Player 1',
        team: match.homeTeam, // Reference team1 for this event
      ),
      MatchEvent(
        description: "Red Card",
        time: DateTime.now().subtract(Duration(minutes: 60)),
        playerName: 'Player 3',
        team: match.awayTeam, // Reference team2 for this event
      ),
      MatchEvent(
        description: "Player Out",
        time: DateTime.now().subtract(Duration(minutes: 60)),
        playerName: 'Player 4',
        team: match.homeTeam, // Reference team1 for this event
      ),
      MatchEvent(
        description: "Player In",
        time: DateTime.now().subtract(Duration(minutes: 60)),
        playerName: 'Player 5',
        team: match.awayTeam, // Reference team2 for this event
      ),
    ]);

  }


  @override
  Widget build(BuildContext context) {
    // Sort matches to put live matches first
    List<Match> sortedMatches = List.from(league.matches);
    sortedMatches.sort((a, b) {
      // Check if the match is live or not
      bool aIsLive = a.matchStatus.toLowerCase() == 'live';
      bool bIsLive = b.matchStatus.toLowerCase() == 'live';

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
              if (league.leagueLogo != null) const SizedBox(width: 12),
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
                      league.leagueLogo,
                      width: 55, // Adjust the size here
                      height: 55,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                league.leagueName,
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
                onTap: (){

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MatchDetailsPage(
                        match: match,
                      ),
                    ),
                  );
                },
                child: MatchItemLive(
                  match: match,
                  backgroundColor: index.isEven ? Colors.transparent : Colors.transparent,
                  isLastItem: index == sortedMatches.length - 1, // Check if it's the last item
                ),
              );
              // Check if the match is live and return the appropriate widget
              // if (match.matchStatus.toLowerCase() == 'live') {
              //   return MatchItemLive(
              //     match: match,
              //     backgroundColor: index.isEven ? Colors.transparent : Colors.transparent,
              //     isLastItem: index == sortedMatches.length - 1, // Check if it's the last item
              //   );
              // } else {
              //   return MatchItemLive(
              //     match: match,
              //     backgroundColor: index.isEven ? Colors.transparent : Colors.transparent,
              //     isLastItem: index == sortedMatches.length - 1, // Check if it's the last item
              //   );
              // }
            },
          ),
        ),
      ],
    );
  }
}
