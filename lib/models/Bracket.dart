import 'Coupe.dart';

class Bracket {
  final int id;
  final Coupe coupe;
  final String type;
  final String teamLength;
  final String fullName;

  Bracket({
    required this.id,
    required this.coupe,
    required this.type,
    required this.teamLength,
    required this.fullName,
  });

  factory Bracket.fromJson(Map<String, dynamic> json) {
    print("Parsing Bracket from JSON: $json"); // Debugging

    // Check if 'bracket' key exists and is not null
    if (json['bracket'] == null) {
      print("'bracket' key is null or missing in JSON: $json");
    }

    return Bracket(
      id: json['id'] ?? 0,
      coupe: Coupe.fromJson(json['coupe'] ?? {}), // Handle null coupe
      type: json['type'] ?? '',
      teamLength: json['team_length'] ?? '',
      fullName: json['full_name'] ?? '',
    );
  }
}