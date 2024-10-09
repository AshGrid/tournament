

import 'package:untitled/models/player.dart';

class Teams {
  final String name;
final int matches;
final int goals;
final int assists;
final int yellowCards;
final int redCards;
final String logo;
final String saison;

  Teams({
required this.matches,
    required this.goals,
    required this.assists,
    required this.yellowCards,
    required this.redCards,
    required this.logo,
    required this.name,
    required this.saison,
  });
}