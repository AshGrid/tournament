import 'package:intl/intl.dart';
import 'package:untitled/models/Team.dart';

import 'MatchEvent.dart';

class Match {
  final Team homeTeam;
  final Team awayTeam;
  final int homeScore;
  final int awayScore;
  final String matchStatus;
  final String matchTime;
  final String homeTeamLogo;
  final String awayTeamLogo;
   String? extraTime;
   final DateTime? matchDate;
  final List<MatchEvent> matchEvents;

  Match({
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
    required this.matchStatus,
    required this.matchTime,
    required this.homeTeamLogo,
    required this.awayTeamLogo,
    this.matchEvents = const [],
    this.matchDate,
  });

  String get formattedDate => DateFormat('yyyy-MM-dd hh:mm').format(matchDate!);
}
