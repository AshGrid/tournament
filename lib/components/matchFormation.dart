import 'package:flutter/material.dart';
import 'package:untitled/components/playercard.dart';
import '../models/match.dart';
import '../models/player.dart';

class MatchFormation extends StatelessWidget {
  final Match match;

  const MatchFormation({Key? key, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Separate lists for home and away players
    final List<Player> homePlayers = match.homeTeam.players ?? [];
    final List<Player> awayPlayers = match.awayTeam.players ?? [];

    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Scrollbar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Home team players on the left
            Expanded(
              child: ListView.builder(
                itemCount: homePlayers.length,
                itemBuilder: (context, index) {
                  final player = homePlayers[index];

                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    alignment: Alignment.centerLeft,
                    child: playerCard(
                      playerName: player.name,
                      playerPosition: player.position,
                      playerImage: player.image,
                    ),
                  );
                },
              ),
            ),
            Container(width: 2,height: 540,color: Colors.black,),
            // Away team players on the right
            Expanded(
              child: ListView.builder(
                itemCount: awayPlayers.length,
                itemBuilder: (context, index) {
                  final player = awayPlayers[index];

                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    alignment: Alignment.centerRight,
                    child: playerCard(
                      playerName: player.name,
                      playerPosition: player.position,
                      playerImage: player.image,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
