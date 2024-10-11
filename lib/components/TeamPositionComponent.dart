import 'package:flutter/material.dart';
import 'package:untitled/components/EffectifItem.dart';
import 'package:untitled/components/playercard.dart';
import 'package:untitled/screens/PlayerDetails.dart';
import '../models/MatchEvent.dart';
import '../models/Position.dart';
import '../models/Team.dart';
import '../models/Match.dart';
import '../models/League.dart';
import '../models/Player.dart';
import 'match_item.dart'; // Import the MatchItem component
import 'match_item_live.dart'; // Import the MatchItemLive component
import 'package:untitled/components/colors.dart'; // Ensure AppColors is correctly imported

class TeamPositionComponent extends StatelessWidget {
  final Position position;
  final Function(Player) onPlayerSelected;

  const TeamPositionComponent({Key? key, required this.position, required this.onPlayerSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sort matches to put live matches first


    return Expanded(
     // height: MediaQuery.of(context).size.height*0.5,
      child: Column(

        children: [
          // League Name and Logo Container
          Container(
            margin: EdgeInsets.only(bottom: 0),
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            height: 80,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColors.leagueComponent,
              border: Border(
                top: BorderSide(color: Colors.white),
                bottom: BorderSide(color: Colors.white),
              ),
            ),
            child: Row(
              children: [

                const SizedBox(width: 12),
                Text(
                  position.name!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ],
            ),
          ),
          // Matches List
          Column(

            children: position.players.asMap().entries.map((entry) {
              // Get the index and the player
              int index = entry.key;
              var player = entry.value;

              // Check if this is the last item
              bool isLastItem = index == position.players.length - 1;

              return GestureDetector(
                onTap: (){
onPlayerSelected(player);
print(player.firstName);
                },
                child: Effectifitem(
                  player: player,
                  playerName: player.firstName!,
                  playerImage: player.avatar!,
                  isLastItem: isLastItem, // You can pass this to the widget if needed
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
