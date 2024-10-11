import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';
import '../components/LeagueComponent.dart';
import '../models/MatchEvent.dart';
import '../models/Team.dart';
import '../models/League.dart';
import '../models/Match.dart';
import '../models/Player.dart';
import 'TeamLeagueComponent.dart';
import 'match_item_live.dart';

class PlayerMatches extends StatefulWidget {
  final Function(Match)? onMatchSelected;

  const PlayerMatches({Key? key, this.onMatchSelected}) : super(key: key);

  @override
  _PlayerMatchesState createState() => _PlayerMatchesState();
}

class _PlayerMatchesState extends State<PlayerMatches> {
  // Sample list of matches
  List<Match> matches = MockData.mockMatches;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 0.0),
        height: MediaQuery.of(context).size.height ,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 0),
          children: matches.asMap().entries.map((entry) {
            int index = entry.key;
            Match match = entry.value;

            bool isFirstItem = index == 0; // Check if it's the first item

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              child: MatchItemLive(
                match: match,
                backgroundColor: Colors.transparent,
                isFirstItem: isFirstItem, // Pass whether it is the first item
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
