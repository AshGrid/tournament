import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';
import 'package:untitled/components/PlayerCardAway.dart';
import 'package:untitled/components/playercard.dart';
import '../Service/data_service.dart';
import '../models/InvitedPlayers.dart';
import '../models/Match.dart';
import '../models/Player.dart';

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
  final fetchedPlayers = await dataService.fetchInvitedPlayers( widget.match.id!);
   setState(() {

     homePlayers  = fetchedPlayers.compositionsDeDepart!.where((player) {
       return player.club?.id == widget.match.home?.id; // Check if player's club is home club
     }).toList();
     awayPlayers  = fetchedPlayers.compositionsDeDepart!.where((player) {
       return player.club?.id == widget.match.away?.id; // Check if player's club is away club
     }).toList();
     homePlayersR = fetchedPlayers.remplacants!.where((player) {
       return player.club?.id == widget.match.home?.id;
     }).toList();
     awayPlayersR = fetchedPlayers.remplacants!.where((player) {
       return player.club?.id == widget.match.away?.id;
     }).toList();


  });
}




  @override
  Widget build(BuildContext context) {
    const double playerRowHeight = 70.0;

    // Find the longest list to determine the divider height
    int longestListLength = homePlayers.length > awayPlayers.length
        ? homePlayers.length
        : awayPlayers.length;
    double dividerHeight = longestListLength * playerRowHeight;

    int longestListLengthR = homePlayersR.length > awayPlayersR.length
        ? homePlayersR.length
        : awayPlayersR.length;
    double dividerHeightR = longestListLengthR * playerRowHeight;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Home team players on the left
                Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: homePlayers.length,
                    itemBuilder: (context, index) {
                      final player = homePlayers[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: Alignment.centerLeft,
                        child: playerCard(
                          playerName: player.firstName!,
                          playerImage: player.avatar!,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 35, bottom: 20),
                  width: 2,
                  height: dividerHeight,
                  color: Colors.black,
                ),
                // Away team players on the right
                Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: awayPlayers.length,
                    itemBuilder: (context, index) {
                      final player = awayPlayers[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: Alignment.centerRight,
                        child: playerCardAway(
                          playerName: player.firstName!,
                          playerImage: player.avatar!,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 35,
              child: Text(
                "Remplaçants",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Oswald'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Home team substitutes on the left
                Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: homePlayersR.length,
                    itemBuilder: (context, index) {
                      final player = homePlayersR[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: Alignment.centerLeft,
                        child: playerCard(
                          playerName: player.firstName!,
                          playerImage: player.avatar!,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  width: 2,
                  height: dividerHeightR,
                  color: Colors.black,
                ),
                // Away team substitutes on the right
                Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: awayPlayersR.length,
                    itemBuilder: (context, index) {
                      final player = awayPlayersR[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: Alignment.centerRight,
                        child: playerCardAway(
                          playerName: player.firstName!,
                          playerImage: player.avatar!,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
