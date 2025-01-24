import 'package:flutter/material.dart';
import '../components/match_item_live.dart';
import '../models/Match.dart'; // Assuming you have a Match model for matches

class SearchScreen extends StatelessWidget {
  final String query;
  final List<Match> matches;
  final Function(Match) onMatchSelected;

  const SearchScreen({Key? key, required this.query, required this.matches, required this.onMatchSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ensure query is not empty
    List<Match> filteredMatches = query.isNotEmpty
        ? matches.where((match) {
      // Check if either home or away team name contains the query (case-insensitive)
      return match.home!.name.toLowerCase().contains(query.toLowerCase()) ||
          match.away!.name.toLowerCase().contains(query.toLowerCase());
    }).toList()
        : [];

    return Container(
      color: Colors.transparent, // Customize as per design
      child: filteredMatches.isEmpty
          ? Center(child: Text('No matches found')) // Show this when no matches match the query
          : ListView.builder(
        itemCount: filteredMatches.length,
        itemBuilder: (context, index) {
          final match = filteredMatches[index];
          return GestureDetector(
            onTap: () => onMatchSelected(match),
            child: MatchItemLive(
              match: match,
              backgroundColor: Colors.transparent, // Customize as per design
              isLastItem: index == filteredMatches.length - 1,
              isFirstItem: index == 0,
            ),
          );
        },
      ),
    );
  }
}
