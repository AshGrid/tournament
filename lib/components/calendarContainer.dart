import 'package:flutter/material.dart';
import '../models/match.dart';
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
      'matches': [
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 1, awayScore: 2, matchStatus: 'finished', matchTime: '19:00', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/monoprix.jpg'),
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 2, awayScore: 1, matchStatus: 'live', matchTime: '20:00', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/monoprix.jpg'),
      ]
    },
    {
      'day': 'Journée 2',
      'matches': [
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 0, awayScore: 3, matchStatus: 'finished', matchTime: '21:00', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/monoprix.jpg'),
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 1, awayScore: 2, matchStatus: 'finished', matchTime: '19:00', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/monoprix.jpg'),
      ]
    },
    {
      'day': 'Journée 3',
      'matches': [
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 1, awayScore: 2, matchStatus: 'finished', matchTime: '19:00', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/monoprix.jpg'),
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 2, awayScore: 1, matchStatus: 'live', matchTime: '20:00', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/monoprix.jpg'),
      ]
    },
    {
      'day': 'Journée 4',
      'matches': [
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 0, awayScore: 3, matchStatus: 'finished', matchTime: '21:00', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/monoprix.jpg'),
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 1, awayScore: 2, matchStatus: 'finished', matchTime: '19:00', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/monoprix.jpg'),
      ]
    },

    {
      'day': 'Journée 5',
      'matches': [
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 0, awayScore: 3, matchStatus: 'finished', matchTime: '21:00', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/monoprix.jpg'),
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 1, awayScore: 2, matchStatus: 'finished', matchTime: '19:00', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/monoprix.jpg'),
      ]
    },
    {
      'day': 'Journée 6',
      'matches': [
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 1, awayScore: 2, matchStatus: 'finished', matchTime: '19:00', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/monoprix.jpg'),
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 2, awayScore: 1, matchStatus: 'live', matchTime: '20:00', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/monoprix.jpg'),
      ]
    },
    {
      'day': 'Journée 7',
      'matches': [
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 0, awayScore: 3, matchStatus: 'finished', matchTime: '21:00', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/monoprix.jpg'),
        Match(homeTeam: 'ennakl', awayTeam: 'monoprix', homeScore: 1, awayScore: 2, matchStatus: 'finished', matchTime: '19:00', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/monoprix.jpg'),
      ]
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
        bool aIsLive = a.matchStatus.toLowerCase() == 'live';
        bool bIsLive = b.matchStatus.toLowerCase() == 'live';

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
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                children: [
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
                    width: 100,
                    color: Colors.white, // Color of the underline
                    margin: const EdgeInsets.only(top: 4), // Space between text and underline
                  ),
                ],
              ),
            ),
            // List of matches for the current day
            Container(
              height: MediaQuery.of(context).size.height * 0.27, // Adjust the height as needed
              width: MediaQuery.of(context).size.width,
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
                  return MatchItem(
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
