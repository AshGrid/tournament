import '../models/match.dart';

class League {
   DateTime? date;
  final String leagueName;
final String leagueLogo;
  final List<Match> matches;

  League({

    required this.leagueName,
required this.leagueLogo,
    required this.matches,
    this.date,
  });
}