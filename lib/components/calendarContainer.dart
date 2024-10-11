import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';
import 'package:untitled/components/match_item_live.dart';
import '../models/Team.dart';
import '../models/Match.dart';
import 'image_slider.dart';
import 'match_item.dart';

class PremierePhaseCalendarScreen extends StatefulWidget {
  const PremierePhaseCalendarScreen({Key? key}) : super(key: key);

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<PremierePhaseCalendarScreen> {
  final List<Map<String, dynamic>> daysWithMatches = [
    {
      'day': 'Journée 1',
      'matches': MockData.mockMatches,
    },
    {
      'day': 'Journée 2',
      'matches': MockData.mockMatches,
    },
    {
      'day': 'Journée 3',
      'matches': MockData.mockMatches,
    },
    {
      'day': 'Journée 4',
      'matches': MockData.mockMatches,
    },

    {
      'day': 'Journée 5',
      'matches': MockData.mockMatches,
    },
    {
      'day': 'Journée 6',
      'matches': MockData.mockMatches,
    },
    {
      'day': 'Journée 7',
      'matches': MockData.mockMatches,
    },
    // Add more days with their respective matches as needed
  ];

  List<String> imagePath = [
    'assets/images/image1.jpeg',
    'assets/images/image2.jpeg',
    'assets/images/image1.jpeg',
  ];

  // Variable to track how many days to display
  int displayedDays = 2;

  @override
  Widget build(BuildContext context) {
    // Sort matches within each day
    for (var day in daysWithMatches) {
      List<Match> sortedMatches = List.from(day['matches']);
      sortedMatches.sort((a, b) {
        bool aIsLive = a.status!.toLowerCase() == 'live';
        bool bIsLive = b.status!.toLowerCase() == 'live';

        if (aIsLive && !bIsLive) return -1;
        if (!aIsLive && bIsLive) return 1;

        return 0;
      });
      day['matches'] = sortedMatches;
    }

    return Container(
      child: Column(
        children: [
          // Display each day and its matches
          for (var i = 0; i < displayedDays && i < daysWithMatches.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left

                children: [
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start, // Aligns the row items to the left
                    children: [
                      Text(
                        daysWithMatches[i]['day'],
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
                    height: 2, // Height of the underline
                    width: daysWithMatches[i]['day'].length *8.0,
                    color: Colors.white, // Color of the underline
                    margin: const EdgeInsets.only(top: 4), // Space between text and underline
                  ),
                ],
              ),
            ),
            // List of matches for the current day
            Container(
              height: MediaQuery.of(context).size.height * 0.25, // Adjust the height as needed
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 0),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: daysWithMatches[i]['matches']?.length ?? 0, // Safeguard against null
                itemBuilder: (context, index) {
                  final matches = daysWithMatches[i]['matches'];
                  // Check for null or empty matches
                  if (matches == null || matches.isEmpty) {
                    return Container(); // Return an empty container if no matches are found
                  }
                  final match = matches[index];
                  return MatchItemLive(
                    match: match,
                    backgroundColor: index.isEven ? Colors.transparent : Colors.transparent,
                    isLastItem: index == matches.length - 1, // Check if it's the last item
                    isFirstItem: index == 0,
                  );
                },
              ),
            ),
          ],
          // "See More" button
          if (displayedDays < daysWithMatches.length)
            TextButton(
              onPressed: () {
                setState(() {
                  displayedDays += 2; // Load two more days
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
