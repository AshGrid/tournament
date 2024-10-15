import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/matchItemFavorite.dart';
import '../components/colors.dart';
import '../models/Match.dart';
import '../models/League.dart'; // Import your League model

class LeagueFavoriteComponent extends StatelessWidget {
  final League league;
  final List<Match> matches; // Accept matches list for the league

  const LeagueFavoriteComponent({
    Key? key,
    required this.league,
    required this.matches, // Pass the matches list
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sort matches to put live matches first
    List<Match> sortedMatches = List.from(matches);
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
            border: const Border(
              top: BorderSide(color: Colors.white),
              bottom: BorderSide(color: Colors.white),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              // Container for the League Logo with border and shadow
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
                      offset: const Offset(2, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Image.asset(
                      "assets/images/${league.name!.toUpperCase()}.png", // League logo based on league name
                      width: 55,
                      height: 55,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                league.name!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Matches List Container
        Column(
          children: List.generate(
            sortedMatches.length,
                (index) {
              final match = sortedMatches[index];
              return MatchItemFavorite(
                match: match,
                backgroundColor: index.isEven ? Colors.transparent : Colors.transparent,
                isLastItem: index == sortedMatches.length - 1,
              );
            },
          ),
        ),
      ],
    );
  }
}
