import 'package:flutter/material.dart';

// Assuming you have a Player model defined as below:
import '../models/Player.dart';
import 'playerCard.dart'; // Assuming you have a separate widget for playerCard

class PlayerListView extends StatelessWidget {
  final List<Player> homePlayers;

  const PlayerListView({
    Key? key,
    required this.homePlayers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
physics: NeverScrollableScrollPhysics(),
      itemCount: homePlayers.length,
      itemBuilder: (context, index) {
        final player = homePlayers[index];

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          alignment: Alignment.centerLeft,
          child: playerCard(
            playerName: player.first_name!,
            //playerPosition: player.position,
            playerImage: player.avatar!,
          ),
        );
      },
    );
  }
}
