import 'package:flutter/material.dart';
import '../models/Player.dart';
// Adjust the import as per your structure

class PlayrCarriere extends StatelessWidget {
  final Player player;

  const PlayrCarriere({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      SizedBox(width: 30, child: Text('MJ', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(width: 30, child: Text('G', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(width: 30, child: Text('A', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(width: 30, child: Text('CJ', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(width: 30, child: Text('CR', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                Divider(),

                // Display player statistics
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Create a single row for the player's stats
                        Container(
                          height: 70.0, // Fixed height for the stat row
                          color: Colors.white, // Background color
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                              // Placeholder for alignment
                                SizedBox(width: 30, child: Text((player.matches_played ?? 0).toString(), textAlign: TextAlign.right)),
                                SizedBox(width: 30, child: Text((player.goals ?? 0).toString(), textAlign: TextAlign.center)),
                                SizedBox(width: 30, child: Text((player.assists ?? 0).toString(), textAlign: TextAlign.center)),
                                SizedBox(width: 30, child: Text((player.yellow_cards ?? 0).toString(), textAlign: TextAlign.center)),
                                SizedBox(width: 30, child: Text((player.red_cards ?? 0).toString(), textAlign: TextAlign.center)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
