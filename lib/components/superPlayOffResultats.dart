import 'package:flutter/material.dart';
import 'package:untitled/components/phaseMatchResultItem.dart';
import '../models/Match.dart';
import '../models/SuperPlayOff.dart';
import 'image_slider.dart';

class Superplayoffresultat extends StatefulWidget {
  final SuperPlayOff superPlayOffData; // Pass SuperPlayOff data

  const Superplayoffresultat({
    Key? key,
    required this.superPlayOffData, // Required SuperPlayOff data
  }) : super(key: key);

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<Superplayoffresultat> {
  int selectedDayIndex = 0;

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
      'Quarterfinals': [
        widget.superPlayOffData.quarter_final_1_home,
        widget.superPlayOffData.quarter_final_1_away,
        widget.superPlayOffData.quarter_final_2_home,
        widget.superPlayOffData.quarter_final_2_away,
        widget.superPlayOffData.quarter_final_3_home,
        widget.superPlayOffData.quarter_final_3_away,
        widget.superPlayOffData.quarter_final_4_home,
        widget.superPlayOffData.quarter_final_4_away,
      ].where((match) => match != null).toList(), // Remove null matches
      'Semifinals': [
        widget.superPlayOffData.semi_final_1_home,
        widget.superPlayOffData.semi_final_1_away,
        widget.superPlayOffData.semi_final_2_home,
        widget.superPlayOffData.semi_final_2_away,
      ].where((match) => match != null).toList(),
      'Final': [
        widget.superPlayOffData.finalmatch,
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
          child: ImageSlider(
            imagePaths: imagePath,
          ),
        ),
      ],
    );
  }
}
