import 'Match.dart';

class RamadanMatches {
  final List<Match> semiFinals;
  final List<Match> finals;

  RamadanMatches({
    required this.semiFinals,
    required this.finals,
  });

  factory RamadanMatches.fromJson(Map<String, dynamic> json) {
    print("Parsing RamadanMatches from JSON: $json"); // Debugging

    // Check if '1_2' key exists and is not null
    if (json['1_2'] == null) {
      print("'1_2' key is null or missing in JSON: $json");
    }

    // Check if 'final' key exists and is not null
    if (json['final'] == null) {
      print("'final' key is null or missing in JSON: $json");
    }

    return RamadanMatches(
      semiFinals: (json['1_2'] as List<dynamic>?)
          ?.map((e) => Match.fromJson(e as Map<String, dynamic>))
          .toList() ?? [], // Handle null semiFinals
      finals: (json['final'] as List<dynamic>?)
          ?.map((e) => Match.fromJson(e as Map<String, dynamic>))
          .toList() ?? [], // Handle null finals
    );
  }
}