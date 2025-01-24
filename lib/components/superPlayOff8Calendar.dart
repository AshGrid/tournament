import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';
import 'package:untitled/components/match_item_live.dart';
import 'package:untitled/models/SuperPlayOff8.dart';
import '../Service/data_service.dart';
import '../models/SuperPlayOff.dart'; // Updated import
import 'image_slider.dart';
import '../models/Match.dart'; // Updated import

class SuperPlayoff8Calendar extends StatefulWidget {
  final SuperPlayOff8 superPlayOff; // Changed to SuperPlayOff
  const SuperPlayoff8Calendar({Key? key, required this.superPlayOff}) : super(key: key);

  @override
  _SuperPlayoff8CalendarState createState() => _SuperPlayoff8CalendarState();
}

int selectedDayIndex = 0;

final List<String> phases = [
  'Quarterfinals',
  'Semifinals',
  'Final',
];

class _SuperPlayoff8CalendarState extends State<SuperPlayoff8Calendar> {
  int displayedRounds = 2; // Variable to track how many rounds to display
  bool isAdsLoading = true;
  final DataService dataService = DataService();

  List<String> imagePaths = [];

  Future<void> _fetchAds() async {
    try {
      final fetchedAds = await dataService.fetchAds();
      setState(() {
        // Filter ads by place, ensure non-null images, and map to their image paths
        imagePaths = fetchedAds
            .where((ad) =>
        ad.place == "home_swiper" &&
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
    // TODO: implement initState
    super.initState();
    _fetchAds();
  }
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


      case 'Semifinals':
        sortedMatches = [
          widget.superPlayOff.semi_final_1_Home,
          widget.superPlayOff.semi_final_1_Away,
          widget.superPlayOff.semi_final_2_Home,
          widget.superPlayOff.semi_final_2_Away,
        ].where((match) => match?.is_ended == false).toList(); // Filter matches that are ongoing
        break;
      case 'Final':
        sortedMatches = [
          widget.superPlayOff.finalMatch,
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
