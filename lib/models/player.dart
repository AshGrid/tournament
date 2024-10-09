

import 'package:intl/intl.dart';
import 'package:untitled/models/Team.dart';

import 'Teams.dart';

class Player {
  final String name;
  final String image;
  final String position;
  final Team? team;
  int? age;
  DateTime? dateNaissance;
   List<Match>? matches;
  List<Teams>? equipes;

  Player({
    required this.name,
    required this.image,
    required this.position,
    this.age,
    this.dateNaissance,
    this.matches,
    this.equipes,
    this.team,
  });
  String get formattedDate => DateFormat('dd-MM-yyyy').format(dateNaissance!);
}
