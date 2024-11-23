import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';
import 'package:untitled/components/Match_item_team_calendar.dart';
import 'package:untitled/components/match_item_live.dart';
import 'package:untitled/models/Club.dart';
import '../Service/data_service.dart';
import '../models/League.dart';
import '../models/Match.dart';
import 'image_slider.dart';

class TeamCalendar extends StatefulWidget {
  final Club team;
  final Function(Match) onMatchSelected;
  const TeamCalendar({Key? key,required this.team,required this.onMatchSelected}) : super(key: key);

  @override
  _TeamCalendarState createState() => _TeamCalendarState();
}

class _TeamCalendarState extends State<TeamCalendar> {
  final DataService dataService = DataService();
  List<Match> matches = []; // List of all matches

  bool isMatchesLoading = true; // Loading state for matches

  // Number of days to display
  int displayedDays = 2;
  bool isAdsLoading = true;


  List<String> imagePaths = [];

  Future<void> _fetchAds() async {
    try {
      final fetchedAds = await dataService.fetchAds();
      setState(() {
        // Filter ads by place, ensure non-null images, and map to their image paths
        imagePaths = fetchedAds
            .where((ad) =>
        ad.place == "club" &&
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
      // Fetch matches from the service
      final fetchedUpcomingMatches = await dataService.fetchUpcomingMatches();

      // Filter the matches by teamId
      final filteredMatches = fetchedUpcomingMatches.where((match) {
        return match.home!.id == widget.team.id || match.away!.id == widget.team.id;
      }).toList();

      // Sort the filtered matches by date
      filteredMatches.sort((a, b) => a.date!.compareTo(b.date!));

      setState(() {
        matches = filteredMatches; // Set the sorted and filtered matches
        isMatchesLoading = false;
      });
    } catch (error) {
      setState(() {
        isMatchesLoading = false;
      });
      print('Error fetching matches: $error');
    }
  }


  // Grouping matches into days (journées)

  @override
  Widget build(BuildContext context) {
    if (isMatchesLoading) {
      return Center(child: CircularProgressIndicator(color: Colors.white,));
    }

    return Container(
      child: Column(
        children: [
          // Display each day and its matches
            // List of matches for the current day
            Container(
              height: (matches.length ?? 0) * 100.0 , // Adjust the height as needed
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 0),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: matches.length ?? 0, // Safeguard against null
                itemBuilder: (context, index) {

                  if ( matches.isEmpty) {
                    return Container(); // Return an empty container if no matches
                  }
                  final match = matches[index];
                  return GestureDetector(
                    onTap: () {
                      widget.onMatchSelected(match);
                    },
                    child:  MatchItemCalendar(
                        match: match,
                        backgroundColor: index.isEven ? Colors.transparent : Colors.transparent,
                        isLastItem: index == matches.length - 1, // Check if it's the last item
                        isFirstItem: index == 0,
                      ),
                  );

                },
              ),
            ),

          // "See More" button

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
