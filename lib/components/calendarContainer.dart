import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';
import 'package:untitled/components/Match_item_team_calendar.dart';
import 'package:untitled/components/match_item_live.dart';
import '../Service/data_service.dart';
import '../models/League.dart';
import '../models/Match.dart';
import 'image_slider.dart';
import 'package:intl/intl.dart';  // Import for date formatting

class PremierePhaseCalendarScreen extends StatefulWidget {
  final int league;
  final Function(Match) onMatchSelected;

  const PremierePhaseCalendarScreen({Key? key, required this.league , required this.onMatchSelected}) : super(key: key);

  @override
  _PremierePhaseCalendarScreenState createState() => _PremierePhaseCalendarScreenState();
}

class _PremierePhaseCalendarScreenState extends State<PremierePhaseCalendarScreen> {
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
      print("League: ${widget.league}");
      final fetchedUpcomingMatches = await dataService.fetchUpcomingMatches();

      matches = fetchedUpcomingMatches.where((match) {
        return (match.home!.league == widget.league) || (match.away!.league == widget.league);
      }).toList();

      // Debugging: Print the number of matches fetched
      print("Fetched Matches in league first phase calendar: ${matches.length}");

      _groupMatchesByDate();

      print("daysWithMatches content: ${daysWithMatches}");

      if (!mounted) return;

      setState(() {
        isMatchesLoading = false;
      });
    } catch (error) {
      print("Error fetching matches: $error");
      if (!mounted) return;
      setState(() {
        isMatchesLoading = false;
      });
    }
  }

  // Helper function to format the date into 'dd-MM-yyyy'
  String _formatDate(DateTime? date) {
    return date != null ? DateFormat('dd-MM-yyyy').format(date) : '';
  }

  String _formatTime(String? timeString) {
    if (timeString == null || timeString.isEmpty) return 'TBD';

    // Split the time string into hours and minutes
    final timeParts = timeString.split(':');
    if (timeParts.length != 3) return 'TBD'; // Return empty if the format is invalid

    final hours = int.tryParse(timeParts[0]);
    final minutes = int.tryParse(timeParts[1]);

    // Validate hours and minutes
    if (hours == null || minutes == null || hours < 0 || hours > 23 || minutes < 0 || minutes > 59) {
      return 'TBD'; // Return empty if invalid
    }

    // Create a DateTime object
    final dateTime = DateTime.now().copyWith(hour: hours, minute: minutes);

    // Format the DateTime object to 'HH:mm'
    return DateFormat('HH:mm').format(dateTime); // Example: "14:30"
  }


  // Group matches by their date
  void _groupMatchesByDate() {
    // Sort matches by date
    matches.sort((a, b) {
      if (a.date != null && b.date != null) {
        return a.date!.compareTo(b.date!);
      }
      return 0; // Default case if one or both dates are null
    });

    Map<String, List<Match>> groupedMatches = {};

    for (var match in matches) {
      String matchDate = _formatDate(match.date!); // Format the date
      if (!groupedMatches.containsKey(matchDate)) {
        groupedMatches[matchDate] = [];
      }
      groupedMatches[matchDate]?.add(match);
    }

    // Sort matches within each day by time using _formatTime
    groupedMatches.forEach((key, value) {
      value.sort((a, b) {
        if (a.time != null && b.time != null) {
          String timeA = _formatTime(a.time);
          String timeB = _formatTime(b.time);
          return timeA.compareTo(timeB); // Sort by formatted time strings
        }
        return 0; // Default case if one or both times are null
      });

      // Print sorted matches for each date
      print("Matches for $key:");
      for (var match in value) {
        print("  Time: ${_formatTime(match.time)}, Match: ${match.home!.name} vs ${match.away!.name}");
      }
    });

    // Convert the map into a list of maps
    daysWithMatches = groupedMatches.entries.map((entry) {
      return {
        'day': entry.key,
        'matches': entry.value,
      };
    }).toList();

    print("Days with matches: ${daysWithMatches.length}");
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
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 0),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true, // Allow ListView to fit within Column
                itemCount: daysWithMatches[i]['matches']?.length ?? 0,
                itemBuilder: (context, index) {
                  final matches = daysWithMatches[i]['matches'];
                  if (matches == null || matches.isEmpty) {
                    return Container(); // Return empty if no matches
                  }
                  final match = matches[index];
                  return GestureDetector(
                    onTap: () {
                      widget.onMatchSelected(match);
                    },
                    child: MatchItemCalendar(
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
