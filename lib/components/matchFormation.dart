import 'package:flutter/material.dart';
import 'package:untitled/components/PlayerCardAway.dart';
import 'package:untitled/components/playercard.dart';
import '../models/match.dart';
import '../models/player.dart';

class MatchFormation extends StatelessWidget {
  final Match match;

  const MatchFormation({Key? key, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Separate lists for home and away players
    // Separate lists for home and away players
    final List<Player> homePlayers = match.homeTeam.players ?? [];
    final List<Player> awayPlayers = match.awayTeam.players ?? [];

    final List<Player> homePlayersR = match.homeTeam.remplacanats ?? [];
    final List<Player> awayPlayersR = match.awayTeam.remplacanats ?? [];

    // Calculate the height of each player's row including padding (e.g., 50 pixels per row)
    const double playerRowHeight = 70.0; // You can adjust this based on your player card height

    // Find the longest list to determine the height for the divider
    int longestListLength = homePlayers.length > awayPlayers.length
        ? homePlayers.length
        : awayPlayers.length;

    // Total height for the divider should match the height required for the longest list
    double dividerHeight = longestListLength * playerRowHeight;

    const double playerRowHeightR = 70.0; // You can adjust this based on your player card height

    // Find the longest list to determine the height for the divider
    int longestListLengthR = homePlayersR.length > awayPlayersR.length
        ? homePlayers.length
        : awayPlayers.length;

    // Total height for the divider should match the height required for the longest list
    double dividerHeightR = longestListLengthR * playerRowHeightR;

    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SingleChildScrollView( // Correct widget for scrolling content
        child: Column(
          children: [
            SizedBox(
              height: 25,
              child: Text("Compositions de départ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,fontFamily: 'Oswald' ),),),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Home team players on the left
                Expanded(
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(), // Keeps scroll disabled within the ListView
                    shrinkWrap: true, // Ensures the ListView takes up only the necessary space
                    children: homePlayers.map((player) {
                      return Container(
                        padding: const EdgeInsets.only(left: 5,right: 5,top: 0,bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: playerCard(
                          playerName: player.name,
                          //playerPosition: player.position,
                          playerImage: player.image,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 35,bottom: 20),
                  width: 2,
                  height: dividerHeight,
                  color: Colors.black,
                ),
                // Away team players on the right
                Expanded(
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: awayPlayers.map((player) {
                      return Container(
                        padding: const EdgeInsets.only(left: 5,right: 5,top: 0,bottom: 10),
                        alignment: Alignment.centerRight,
                        child: playerCardAway(
                          playerName: player.name,
                          // playerPosition: player.position,
                          playerImage: player.image,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

              SizedBox(
                height: 35,
                child: Text("Remplaçants",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,fontFamily: 'Oswald' ),),),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Home team players on the left
                  Expanded(
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(), // Keeps scroll disabled within the ListView
                      shrinkWrap: true, // Ensures the ListView takes up only the necessary space
                      children: homePlayersR.map((player) {
                        return Container(
                          padding: const EdgeInsets.only(left: 5,right: 5,top: 0,bottom: 10),
                          alignment: Alignment.centerLeft,
                          child: playerCard(
                            playerName: player.name,
                            //playerPosition: player.position,
                            playerImage: player.image,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(margin: EdgeInsets.only(top: 5,bottom: 10),
                    width: 2,
                    height: dividerHeight,
                    color: Colors.black,
                  ),
                  // Away team players on the right
                  Expanded(
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: awayPlayersR.map((player) {
                        return Container(
                          padding: const EdgeInsets.only(left: 5,right: 5,top: 0,bottom: 10),
                          alignment: Alignment.centerRight,
                          child: playerCardAway(
                            playerName: player.name,
                            // playerPosition: player.position,
                            playerImage: player.image,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ],

        )
      ),
    );
  }
}
