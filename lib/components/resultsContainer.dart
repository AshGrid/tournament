import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../Service/data_service.dart';
import '../models/League.dart';
import '../models/Match.dart';
import '../components/phaseMatchResultItem.dart';
import 'Match_item_team_calendar.dart';
import 'image_slider.dart';

class PremierePhaseResultsScreen extends StatefulWidget {
  final League league;
  final Function(Match) onMatchSelected;

  const PremierePhaseResultsScreen({Key? key, required this.league,required this.onMatchSelected}) : super(key: key);

  @override
  _PremierePhaseResultsScreenState createState() => _PremierePhaseResultsScreenState();
}

class _PremierePhaseResultsScreenState extends State<PremierePhaseResultsScreen> {
  final DataService dataService = DataService();
  List<Match> matches = [];
  List<Map<String, dynamic>> daysWithMatches = []; // To hold matches grouped by days
  bool isMatchesLoading = true;
  int displayedDays = 2; // Number of displayed days
  bool isAdsLoading = true;


  List<String> imagePaths = [];

  Future<void> _fetchAds() async {
    try {
      final fetchedAds = await dataService.fetchAds();
      setState(() {
        // Filter ads by place, ensure non-null images, and map to their image paths
        imagePaths = fetchedAds
            .where((ad) =>
        ad.place == "premiere_phase" &&
            ad.image != null) // Filter by place and non-null images
            .map((ad) => ad
            .image!) // Use non-null assertion to convert String? to String
            .toList();
        isAdsLoading = false; // Set loading to false after fetching ads
      });
    } catch (e) {
      print("Error fetching ads for home screen: $e");
      setState(() {
        isAdsLoading = false; // Stop loading on error
      });
    }
  }


  @override
  void initState() {
    super.initState();
    _fetchMatches();
    _fetchAds();
  }

  Future<void> _fetchMatches() async {
    try {
      final fetchPlayedMatches = await dataService.fetchPlayedMatches();
      matches = fetchPlayedMatches.where((match) {
        return (match.home!.league == widget.league.id) && (match.away!.league == widget.league.id);
      }).toList();

      print("matches:${widget.league}");
      // Debugging: Print fetched matches
      print("Fetched Matches in league first phase calendar: ${matches.length}");

      _groupMatchesByDate();
      setState(() {
        isMatchesLoading = false;
      });
    } catch (error) {
      setState(() {
        isMatchesLoading = false;
      });
    }
  }

  // Helper function to format date into 'Day, Month Date'
  String _formatDate(DateTime date) {
    return DateFormat('dd- MM -yyyy').format(date); // Example: "Tuesday, September 14"
  }

  // Group matches by their date
  void _groupMatchesByDate() {
    Map<String, List<Match>> groupedMatches = {};

    for (var match in matches) {
      String matchDate = _formatDate(match.date!); // Get formatted date
      if (!groupedMatches.containsKey(matchDate)) {
        groupedMatches[matchDate] = [];
      }
      groupedMatches[matchDate]!.add(match);
    }

    // Convert the map into a list of maps
    daysWithMatches = groupedMatches.entries.map((entry) {
      return {
        'day': entry.key,
        'matches': entry.value,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (isMatchesLoading) {
      return Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return Container(

      child: Column(
        children: [
          // Display each day and its matches
          for (var i = 0; i < displayedDays && i < daysWithMatches.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        daysWithMatches[i]['day'],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  // Underline
                  Container(
                    height: 2,
                    width: daysWithMatches[i]['day'].length * 8.0,
                    color: Colors.white,
                    margin: const EdgeInsets.only(top: 4),
                  ),
                ],
              ),
            ),
            // List of matches for the current day
            Container(
              height: (daysWithMatches[i]['matches']?.length ?? 0) * 140.0, // Adjust the height as needed
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 0),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: daysWithMatches[i]['matches']?.length ?? 0,
                itemBuilder: (context, index) {
                  final matches = daysWithMatches[i]['matches'];
                  if (matches == null || matches.isEmpty) {
                    return Container(); // Return empty if no matches
                  }
                  final match = matches[index];
                  return GestureDetector(
                    onTap:(){
                      widget.onMatchSelected(match);
                    },
                    child: PhaseMatchResultItem(
                      match: match,
                      backgroundColor: index.isEven ? Colors.transparent : Colors.transparent,
                      isLastItem: index == matches.length - 1,
                      isFirstItem: index == 0,
                    ),
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
            child: isAdsLoading
                ? const Center(
              child: CircularProgressIndicator(), // Loading icon
            )
                : Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8, horizontal: 8),
              child: ImageSlider(
                imagePaths: imagePaths,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
