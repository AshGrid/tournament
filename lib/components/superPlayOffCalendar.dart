import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';
import 'package:untitled/components/match_item_live.dart';
import '../models/SuperPlayOff.dart'; // Updated import
import 'image_slider.dart';
import '../models/Match.dart'; // Updated import

class SuperPlayoffCalendar extends StatefulWidget {
  final SuperPlayOff superPlayOff; // Changed to SuperPlayOff
  const SuperPlayoffCalendar({Key? key, required this.superPlayOff}) : super(key: key);

  @override
  _SuperPlayoffCalendarState createState() => _SuperPlayoffCalendarState();
}

int selectedDayIndex = 0;

final List<String> phases = [
  'Quarterfinals',
  'Semifinals',
  'Final',
];

class _SuperPlayoffCalendarState extends State<SuperPlayoffCalendar> {
  int displayedRounds = 2; // Variable to track how many rounds to display

  List<String> imagePath = [
    'assets/images/image1.jpeg',
    'assets/images/image2.jpeg',
    'assets/images/image1.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    // Get organized matches by phase from the SuperPlayOff class
    List<Match?> sortedMatches = [];

    switch (phases[selectedDayIndex]) {
      case 'Quarterfinals':
        sortedMatches = [
          widget.superPlayOff.quarter_final_1_home,
          widget.superPlayOff.quarter_final_1_away,
          widget.superPlayOff.quarter_final_2_home,
          widget.superPlayOff.quarter_final_2_away,
          widget.superPlayOff.quarter_final_3_home,
          widget.superPlayOff.quarter_final_3_away,
          widget.superPlayOff.quarter_final_4_home,
          widget.superPlayOff.quarter_final_4_away,
        ].where((match) => match?.is_ended == false).toList(); // Filter matches that are ongoing
        break;
      case 'Semifinals':
        sortedMatches = [
          widget.superPlayOff.semi_final_1_home,
          widget.superPlayOff.semi_final_1_away,
          widget.superPlayOff.semi_final_2_home,
          widget.superPlayOff.semi_final_2_away,
        ].where((match) => match?.is_ended == false).toList(); // Filter matches that are ongoing
        break;
      case 'Final':
        sortedMatches = [
          widget.superPlayOff.finalmatch,
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
              height: MediaQuery.of(context).size.height, // Height adjustment
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
