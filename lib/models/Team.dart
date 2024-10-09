

import 'package:untitled/models/player.dart';

class Team {
  final int rank;
  final String name;
  final int matchesPlayed;
  final int goals;
  final int points;
  final String logo;
  final List<Player>? players;
  final List<Player>? remplacanats;
  final String? league;

  Team({
    required this.rank,
    required this.name,
    required this.matchesPlayed,
    required this.goals,
    required this.points,
    required this.logo,
    this.players,
    this.remplacanats,
    this.league,
  });
}