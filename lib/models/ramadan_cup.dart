import 'package:untitled/models/ramdan_matches.dart';

import 'Bracket.dart';


class BracketData {
  final Bracket bracket;
  final RamadanMatches matches;

  BracketData({
    required this.bracket,
    required this.matches,
  });

  factory BracketData.fromJson(Map<String, dynamic> json) {
    print("Parsing BracketData from JSON: $json"); // Debugging

    // Check if 'bracket' key exists and is not null
    if (json['bracket'] == null) {
      print("'bracket' key is null or missing in JSON: $json");
    }

    // Check if 'matches' key exists and is not null
    if (json['matches'] == null) {
      print("'matches' key is null or missing in JSON: $json");
    }

    return BracketData(
      bracket: Bracket.fromJson(json['bracket'] ?? {}), // Handle null bracket
      matches: RamadanMatches.fromJson(json['matches'] ?? {}), // Handle null matches
    );
  }
}