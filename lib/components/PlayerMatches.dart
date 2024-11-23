import 'package:flutter/material.dart';
import 'package:untitled/Service/data_service.dart';
import '../models/Match.dart';
import '../models/Player.dart';
import 'match_item_live.dart';

class PlayerMatches extends StatefulWidget {
  final Function(Match)? onMatchSelected;
  final Player player; // Player object to filter matches

  const PlayerMatches({Key? key, this.onMatchSelected, required this.player}) : super(key: key);

  @override
  _PlayerMatchesState createState() => _PlayerMatchesState();
}

class _PlayerMatchesState extends State<PlayerMatches> {
  DataService dataService = DataService();
  List<Match> matches = [];

  @override
  void initState() {
    super.initState();
    _fetchMatches();
  }

  Future<void> _fetchMatches() async {
    try {
      final fetchedMatches = await dataService.fetchPlayedMatches();
      if (mounted) {
        setState(() {
          // Filter matches based on the player's club
          matches = fetchedMatches.where((match) {
            return match.home?.id == widget.player.club || match.away?.id == widget.player.club;
          }).toList();

          // Sort the filtered matches by date
          matches.sort((a, b) => a.date!.compareTo(b.date!));
        });
      }
    } catch (error) {
      print("Error fetching matches: $error");
      // Optionally, handle the error further here, e.g., showing an error message in the UI
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 0.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 0),
          children: matches.asMap().entries.map((entry) {
            int index = entry.key;
            Match match = entry.value;

            bool isFirstItem = index == 0; // Check if it's the first item

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              child: GestureDetector(
                onTap: () {
                  if (widget.onMatchSelected != null) {
                    widget.onMatchSelected!(match);
                  }
                },
                child: MatchItemLive(
                  match: match,
                  backgroundColor: Colors.transparent,
                  isFirstItem: isFirstItem, // Pass whether it is the first item
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
