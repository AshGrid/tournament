import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';
import 'package:untitled/components/match_item_live.dart';
import '../models/Coupe8.dart';
import '../models/Match.dart';
import 'image_slider.dart';

class Coupe8Calendar extends StatefulWidget {
  final Coupe8 coupe;

  const Coupe8Calendar({Key? key, required this.coupe}) : super(key: key);

  @override
  _Coupe8CalendarState createState() => _Coupe8CalendarState();
}

class _Coupe8CalendarState extends State<Coupe8Calendar> {
  // Variable to track how many rounds to display
  int displayedRounds = 2;

  List<String> imagePath = [
    'assets/images/image1.jpeg',
    'assets/images/image2.jpeg',
    'assets/images/image1.jpeg',
  ];

  // Define the phases for the Coupe8
  final List<String> phases = [
    'Quarterfinal',
    'Semifinal',
    'Final',
  ];

  @override
  Widget build(BuildContext context) {
    // Get organized matches by phase from the Coupe8 class
    List<Match?> sortedMatches = [];

    for (var phase in phases) {
      switch (phase) {
        case 'Quarterfinal':
          sortedMatches = [
            widget.coupe.quarter_final_1,
            widget.coupe.quarter_final_2,
            widget.coupe.quarter_final_3,
            widget.coupe.quarter_final_4,
          ].where((match) => match?.is_ended == false).toList(); // Filter matches that are ongoing
          break;
        case 'Semifinal':
          sortedMatches = [
            widget.coupe.semi_final_1,
            widget.coupe.semi_final_2,
          ].where((match) => match?.is_ended == false).toList(); // Filter matches that are ongoing
          break;
        case 'Final':
          sortedMatches = [
            widget.coupe.finalMatch,
          ].where((match) => match?.is_ended == false).toList(); // Filter matches that are ongoing
          break;
      }
    }

    // Define the rounds with matches to display
    final List<Map<String, dynamic>> roundsWithMatches = [
      {
        'round': 'Quarterfinal',
        'matches': sortedMatches,
      },
      {
        'round': 'Semifinal',
        'matches': sortedMatches,
      },
      {
        'round': 'Final',
        'matches': sortedMatches,
      },
    ];

    return Container(
      child: Column(
        children: [
          // Display each round and its matches
          for (var i = 0; i < displayedRounds && i < roundsWithMatches.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        roundsWithMatches[i]['round'],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  // Underline
                  Container(
                    height: 2,
                    width: roundsWithMatches[i]['round'] == "Quarterfinal" ? 110 : roundsWithMatches[i]['round'] == "Semifinal" ? 90 : 50,
                    color: Colors.white,
                    margin: const EdgeInsets.only(top: 4),
                  ),
                ],
              ),
            ),
            // List of matches for the current round
            Container(
              height: MediaQuery.of(context).size.height * 0.27,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: roundsWithMatches[i]['matches']?.length ?? 0,
                itemBuilder: (context, index) {
                  final matches = roundsWithMatches[i]['matches'];
                  if (matches == null || matches.isEmpty) {
                    return Container();
                  }
                  final match = matches[index];
                  return MatchItemLive(
                    match: match,
                    backgroundColor: index.isEven ? Colors.transparent : Colors.transparent,
                    isLastItem: index == matches.length - 1,
                    isFirstItem: index == 0,
                  );
                },
              ),
            ),
          ],
          // "See More" button
          if (displayedRounds < roundsWithMatches.length)
            TextButton(
              onPressed: () {
                setState(() {
                  displayedRounds += 1; // Load one more round
                });
              },
              child: Text(
                'See More',
                style: TextStyle(color: Colors.white),
              ),
            ),
          // Image slider at the bottom
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: ImageSlider(
              imagePaths: imagePath,
            ),
          ),
        ],
      ),
    );
  }
}