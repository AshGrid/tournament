import 'package:flutter/material.dart';
import '../models/MatchEvent.dart';
import '../models/Team.dart';
import '../models/match.dart';
import '../models/league.dart';
import 'match_item.dart'; // Import the MatchItem component
import 'match_item_live.dart'; // Import the MatchItemLive component
import 'package:untitled/components/colors.dart'; // Ensure AppColors is correctly imported

class TeamLeagueComponent extends StatelessWidget {
  final League league;

  const TeamLeagueComponent({Key? key, required this.league}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sort matches to put live matches first
    List<Match> sortedMatches = List.from(league.matches);
    sortedMatches.sort((a, b) {
      bool aIsLive = a.matchStatus.toLowerCase() == 'live';
      bool bIsLive = b.matchStatus.toLowerCase() == 'live';

      return aIsLive == bIsLive ? 0 : aIsLive ? -1 : 1; // Prioritize live matches
    });

    return Column(

      children: [
        // League Name and Logo Container
        Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.leagueComponent,
            border: Border(
              top: BorderSide(color: Colors.white),
              bottom: BorderSide(color: Colors.white),
            ),
          ),
          child: Row(
            children: [
              if (league.leagueLogo != null) ...[
                const SizedBox(width: 12),
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: AppColors.teamLogoBorder, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.teamLogoShadow,
                        offset: Offset(2, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(league.leagueLogo, fit: BoxFit.cover),
                  ),
                ),
              ],
              const SizedBox(width: 12),
              Text(
                league.leagueName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        // Matches List
        Column(
          children: sortedMatches.map((match) {
            // Choose MatchItem or MatchItemLive based on match status
            return
                 MatchItemLive(match: match, backgroundColor: Colors.transparent,);

          }).toList(),
        ),
      ],
    );
  }
}
