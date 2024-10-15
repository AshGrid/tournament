import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';
import 'package:untitled/components/match_item_live.dart';
import '../Service/data_service.dart';
import '../models/League.dart';
import '../models/Match.dart';
import 'image_slider.dart';

class PremierePhaseCalendarScreen extends StatefulWidget {
  final int league;
  const PremierePhaseCalendarScreen({Key? key,required this.league}) : super(key: key);

  @override
  _PremierePhaseCalendarScreenState createState() => _PremierePhaseCalendarScreenState();
}

class _PremierePhaseCalendarScreenState extends State<PremierePhaseCalendarScreen> {
  final DataService dataService = DataService();
  List<Match> matches = []; // List of all matches
  List<Map<String, dynamic>> daysWithMatches = []; // To hold matches grouped by days
  bool isMatchesLoading = true; // Loading state for matches

  // Number of days to display
  int displayedDays = 2;

  @override
  void initState() {
    super.initState();
    _fetchMatches();
  }

  Future<void> _fetchMatches() async {
    try {
      //final fetchedMatches = await dataService.fetchPlayedMatches();
      final fetchedUpcomingMatches = await dataService.fetchUpcomingMatches();
      setState(() {
        matches = [...fetchedUpcomingMatches,];  // Combine both types of matches
        isMatchesLoading = false;
        _groupMatchesByDays(); // Group matches after loading
      });
    } catch (error) {
      setState(() {
        isMatchesLoading = false;
      });
    }
  }

  // Grouping matches into days (journées)
  void _groupMatchesByDays() {
    // Assuming that `MockData.mockMatches` have appropriate day information.
    daysWithMatches = [
      {'day': 'Journée 1', 'matches': matches},
      {'day': 'Journée 2', 'matches': matches},
      {'day': 'Journée 3', 'matches':matches},
      {'day': 'Journée 4', 'matches': matches},
      {'day': 'Journée 5', 'matches': matches},
      {'day': 'Journée 6', 'matches': matches},
      {'day': 'Journée 7', 'matches': matches},
      // Add more days and their matches as necessary
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (isMatchesLoading) {
      return Center(child: CircularProgressIndicator(color: Colors.white,));
    }

    return Container(
      child: Column(
        children: [
          // Display each day and its matches
          for (var i = 0; i < displayedDays && i < daysWithMatches.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start, // Align the row items to the left
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
                    width: daysWithMatches[i]['day'].length * 8.0,
                    color: Colors.white, // Color of the underline
                    margin: const EdgeInsets.only(top: 4), // Space between text and underline
                  ),
                ],
              ),
            ),
            // List of matches for the current day
            Container(
              height: (daysWithMatches[i]['matches']?.length ?? 0) * 100.0 , // Adjust the height as needed
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 0),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: daysWithMatches[i]['matches']?.length ?? 0, // Safeguard against null
                itemBuilder: (context, index) {
                  final matches = daysWithMatches[i]['matches'];
                  if (matches == null || matches.isEmpty) {
                    return Container(); // Return an empty container if no matches
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
              imagePaths: [
                'assets/images/image1.jpeg',
                'assets/images/image2.jpeg',
                'assets/images/image1.jpeg',
              ],
            ),
          ),
        ],
      ),
    );
  }
}
