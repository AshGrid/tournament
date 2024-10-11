import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';
import 'package:untitled/components/match_item_live.dart';
import '../models/Team.dart';
import '../models/Match.dart';
import 'image_slider.dart';
import 'match_item.dart';

class Superplayoffcalendar extends StatefulWidget {
  const Superplayoffcalendar({Key? key}) : super(key: key);

  @override
  _SuperplayoffCalendarState createState() => _SuperplayoffCalendarState();
}

class _SuperplayoffCalendarState extends State<Superplayoffcalendar> {
  final List<Map<String, dynamic>> roundsWithMatches = [
    {
      'round': 'Quarterfinal',
      'matches': MockData.mockMatches
    },
    {
      'round': 'Semifinal',
      'matches': MockData.mockMatches
    },
    {
      'round': 'Final',
      'matches': MockData.mockMatches
    },
  ];

  List<String> imagePath = [
    'assets/images/image1.jpeg',
    'assets/images/image2.jpeg',
    'assets/images/image1.jpeg',
  ];

  // Variable to track how many rounds to display
  int displayedRounds = 2;

  @override
  Widget build(BuildContext context) {
    // Sort matches within each round
    for (var round in roundsWithMatches) {
      List<Match> sortedMatches = List.from(round['matches']);
      sortedMatches.sort((a, b) {
        bool aIsLive = a.status!.toLowerCase() == 'live';
        bool bIsLive = b.status!.toLowerCase() == 'live';

        if (aIsLive && !bIsLive) return -1;
        if (!aIsLive && bIsLive) return 1;

        return 0;
      });
      round['matches'] = sortedMatches;
    }

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
                    width: roundsWithMatches[i]['round'] == "Quarterfinal" ?  110 : roundsWithMatches[i]['round'] == "Semifinal" ? 90 : 50,
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
