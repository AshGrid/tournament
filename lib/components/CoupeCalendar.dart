import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';
import 'package:untitled/components/match_item_live.dart';
import '../models/Coupe.dart';
import '../models/Match.dart';
import 'image_slider.dart';

class CoupeCalendar extends StatefulWidget {
  final Coupe coupe;
  const CoupeCalendar({Key? key, required this.coupe}) : super(key: key);

  @override
  _CoupeCalendarState createState() => _CoupeCalendarState();
}

int selectedDayIndex = 0;

final List<String> phases = [
  'round 1',
  'Quarterfinals',
  'Semifinals',
  'Final',
];

class _CoupeCalendarState extends State<CoupeCalendar> {
  int displayedRounds = 2; // Variable to track how many rounds to display

  List<String> imagePath = [
    'assets/images/image1.jpeg',
    'assets/images/image2.jpeg',
    'assets/images/image1.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    // Get organized matches by phase from the Coupe class
    List<Match?> sortedMatches = [];

    switch (phases[selectedDayIndex]) {
      case 'round 1':
        sortedMatches = [
          widget.coupe.round_1,
          widget.coupe.round_2,
          widget.coupe.round_3,
          widget.coupe.round_4,
          widget.coupe.round_5,
          widget.coupe.round_6,
          widget.coupe.round_7,
          widget.coupe.round_8,
        ].where((match) => match?.is_ended == false).toList(); // Filter matches that are ongoing
        break;
      case 'Quarterfinals':
        sortedMatches = [
          widget.coupe.quarter_final_1,
          widget.coupe.quarter_final_2,
          widget.coupe.quarter_final_3,
          widget.coupe.quarter_final_4,
        ].where((match) => match?.is_ended == false).toList(); // Filter matches that are ongoing
        break;
      case 'Semifinals':
        sortedMatches = [
          widget.coupe.semi_final_1,
          widget.coupe.semi_final_2,
        ].where((match) => match?.is_ended == false).toList(); // Filter matches that are ongoing
        break;
      case 'Final':
        sortedMatches = [
          widget.coupe.finalmatch,
        ].where((match) => match?.is_ended == false).toList(); // Filter matches that are ongoing
        break;
    }

    // Create a list of rounds with their respective matches
    List<Map<String, dynamic>> roundsWithMatches = [
      {
        'round': phases[selectedDayIndex],
        'matches': sortedMatches,
      }
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8), // Padding for better spacing
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
                    width: roundsWithMatches[i]['round'] == "Quarterfinals" ? 110 :
                    roundsWithMatches[i]['round'] == "Semifinals" ? 90 : 50,
                    color: Colors.white,
                    margin: const EdgeInsets.only(top: 4),
                  ),
                ],
              ),
            ),
            // List of matches for the current round
            SizedBox(
              height: MediaQuery.of(context).size.height , // Height adjustment
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
