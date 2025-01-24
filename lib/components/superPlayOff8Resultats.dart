import 'package:flutter/material.dart';
import 'package:untitled/components/phaseMatchResultItem.dart';
import '../Service/data_service.dart';
import '../models/Match.dart';
import '../models/SuperPlayOff.dart';
import '../models/SuperPlayOff8.dart';
import 'image_slider.dart';

class Superplayoff8resultat extends StatefulWidget {
  final SuperPlayOff8 superPlayOffData; // Pass SuperPlayOff data

  const Superplayoff8resultat({
    Key? key,
    required this.superPlayOffData, // Required SuperPlayOff data
  }) : super(key: key);

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<Superplayoff8resultat> {
  int selectedDayIndex = 0;
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
  final List<String> phases = [
    'Quarterfinals',
    'Semifinals',
    'Final',
  ];

  List<String> imagePath = [
    'assets/images/image1.jpeg',
    'assets/images/image2.jpeg',
    'assets/images/image1.jpeg',
  ];

  // Organize matches by phase
  Map<String, List<Match?>> matchesByPhase() {
    return {

      'Semifinals': [
        widget.superPlayOffData.semi_final_1_Home,
        widget.superPlayOffData.semi_final_1_Away,
        widget.superPlayOffData.semi_final_2_Home,
        widget.superPlayOffData.semi_final_2_Away,
      ].where((match) => match != null).toList(),
      'Final': [
        widget.superPlayOffData.finalMatch,
      ].where((match) => match != null).toList(),
    };
  }

  @override
  Widget build(BuildContext context) {
    List<Match?> sortedMatches = matchesByPhase()[phases[selectedDayIndex]] ?? [];

    sortedMatches.sort((a, b) {
      bool aIsLive = a?.status?.toLowerCase() == 'live';
      bool bIsLive = b?.status?.toLowerCase() == 'live';

      if (aIsLive && !bIsLive) return -1;
      if (!aIsLive && bIsLive) return 1;

      return 0;
    });

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: phases.asMap().entries.map((entry) {
                int index = entry.key;
                String phase = entry.value;
                bool isSelected = index == selectedDayIndex;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDayIndex = index;
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          phase,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isSelected)
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: 70,
                            height: 2,
                            color: Colors.white,
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.6, // Adjust height as needed
          width: MediaQuery.of(context).size.width,
          child: Scrollbar(
            thickness: 4.0, // Adjust thickness as needed
            child: ListView.builder(
              itemCount: sortedMatches.length,
              itemBuilder: (context, index) {
                final match = sortedMatches[index];
                return PhaseMatchResultItem(
                  match: match!,
                  backgroundColor: index.isEven ? Colors.transparent : Colors.transparent,
                  isLastItem: index == sortedMatches.length - 1, // Check if it's the last item
                  isFirstItem: index == 0,
                );
              },
            ),
          ),
        ),
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
    );
  }
}
