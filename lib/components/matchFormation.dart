import 'package:flutter/material.dart';
import '../Service/data_service.dart';
import '../models/InvitedPlayers.dart';
import '../models/Match.dart';
import '../models/Player.dart';
import 'PlayerCardAway.dart';
import 'playercard.dart';

class MatchFormation extends StatefulWidget {
  final Match match;

  const MatchFormation({Key? key, required this.match}) : super(key: key);

  @override
  _MatchFormationState createState() => _MatchFormationState();
}

class _MatchFormationState extends State<MatchFormation> {
  final DataService dataService = DataService();

  List<Player> homePlayers = [];
  List<Player> awayPlayers = [];
  List<Player> homePlayersR = [];
  List<Player> awayPlayersR = [];

  @override
  void initState() {
    super.initState();
    _fetchPlayers();
  }

  Future<void> _fetchPlayers() async {
    final fetchedPlayers = await dataService.fetchInvitedPlayers(widget.match.id!);

    setState(() {
      // Assuming 'teamId' is used to differentiate teams
      final homeTeamId = widget.match.home!.id; // Get home team ID from match data
      final awayTeamId = widget.match.away!.id; // Get away team ID from match data

      // Determine home and away players based on team ID
      if (fetchedPlayers[0].club!.id == homeTeamId) {
        homePlayers = fetchedPlayers[0].compositions_de_depart!;
        homePlayersR = fetchedPlayers[0].remplacants!;

        awayPlayers = fetchedPlayers[1].compositions_de_depart!;
        awayPlayersR = fetchedPlayers[1].remplacants!;
      } else {
        homePlayers = fetchedPlayers[1].compositions_de_depart!;
        homePlayersR = fetchedPlayers[1].remplacants!;

        awayPlayers = fetchedPlayers[0].compositions_de_depart!;
        awayPlayersR = fetchedPlayers[0].remplacants!;
      }

      // Debugging output to verify data
      print("Home players: ${homePlayers.length}");
      print("Away players: ${awayPlayers.length}");
      print("Home substitutes: ${homePlayersR.length}");
      print("Away substitutes: ${awayPlayersR.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    const double playerRowHeight = 70.0;

    // Determine the divider height for starters and substitutes
    double dividerHeight = _calculateDividerHeight(homePlayers, awayPlayers, playerRowHeight);
    double dividerHeightR = _calculateDividerHeight(homePlayersR, awayPlayersR, playerRowHeight);

    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
              child: Text(
                "Compositions de départ",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Oswald'),

              ),
            ),
            _buildPlayerRow(homePlayers, awayPlayers, dividerHeight, playerRowHeight),
            const SizedBox(
              height: 35,
              child: Text(
                "Remplaçants",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Oswald'),
              ),
            ),
            _buildPlayerRow(homePlayersR, awayPlayersR, dividerHeightR, playerRowHeight),
          ],
        ),
      ),
    );
  }

  // Helper method to calculate divider height
  double _calculateDividerHeight(List<Player> homePlayers, List<Player> awayPlayers, double rowHeight) {
    int longestListLength = homePlayers.length > awayPlayers.length
        ? homePlayers.length
        : awayPlayers.length;
    return longestListLength * rowHeight;
  }

  // Helper method to build player rows
  Widget _buildPlayerRow(List<Player> homePlayers, List<Player> awayPlayers, double dividerHeight, double rowHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Away team players on the left
        Expanded(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: homePlayers.length,
            itemBuilder: (context, index) {
              final player = homePlayers[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                alignment: Alignment.centerLeft, // Align left for away team
                child: playerCard(
                  playerName: "${player.first_name!} ${player.last_name!}",
                  playerImage: player.avatar!,
                ),
              );
            },
          ),
        ),
        // Vertical divider between home and away players
        Container(
          margin: const EdgeInsets.only(top: 35, bottom: 20),
          width: 2,
          height: dividerHeight,
          color: Colors.black,
        ),
        // Home team players on the right
        Expanded(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: awayPlayers.length,
            itemBuilder: (context, index) {
              final player = awayPlayers[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                alignment: Alignment.centerRight, // Align right for home team
                child: playerCardAway(
                  playerName: "${player.first_name!} ${player.last_name!}",
                  playerImage: player.avatar!,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
