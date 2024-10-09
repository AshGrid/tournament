
import 'package:untitled/models/player.dart';

class Position {

  final String name;
  final List<Player> players;
  final List<Player>? remplacanats;

  Position({

    required this.name,
    required this.players,
    this.remplacanats,
  });
}