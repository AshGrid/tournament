class Match {
  final String homeTeam;
  final String awayTeam;
  final int homeScore;
  final int awayScore;
  final String matchStatus;
  final String matchTime;
  final String homeTeamLogo;
  final String awayTeamLogo;
   String? extraTime;

  Match({
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
    required this.matchStatus,
    required this.matchTime,
    required this.homeTeamLogo,
    required this.awayTeamLogo
  });
}
