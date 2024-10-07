

import 'package:untitled/models/Team.dart';

class Player {
  final String name;
  final String image;
  final String position;
  final Team? team;

  Player({
    required this.name,
    required this.image,
    required this.position,
    this.team,
  });
}
