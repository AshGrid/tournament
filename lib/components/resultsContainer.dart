import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';
import 'package:untitled/components/phaseMatchResultItem.dart';
import '../models/Team.dart';
import '../models/Match.dart';
import 'image_slider.dart';
import 'match_item.dart';
import 'match_item_live.dart';

class PremierePhaseResultsScreen extends StatefulWidget {
  const PremierePhaseResultsScreen({Key? key}) : super(key: key);

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<PremierePhaseResultsScreen> {
  int selectedDayIndex = 0;

  final List<String> days = [
    'Journée 1',
    'Journée 2',
    'Journée 3',
    'Journée 4',
    'Journée 5',
    'Journée 6',
    'Journée 7',
  ];
  List<String> imagePath = [
    'assets/images/image1.jpeg',
    'assets/images/image2.jpeg',
    'assets/images/image1.jpeg',
  ];

  List<Match> matches = MockData.mockMatches;

  @override
  @override
  Widget build(BuildContext context) {
    List<Match> sortedMatches = List.from(matches);
    sortedMatches.sort((a, b) {
      bool aIsLive = a.status!.toLowerCase() == 'live';
      bool bIsLive = b.status!.toLowerCase() == 'live';

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
              children: days.asMap().entries.map((entry) {
                int index = entry.key;
                String day = entry.value;
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
                          day,
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
          height: MediaQuery.of(context).size.height * 0.6, // Adjust the height as needed
          width: MediaQuery.of(context).size.width,
          child: Scrollbar(
            // Add scrollbar here
            thickness: 4.0, // Adjust thickness as needed
            //isAlwaysShown: true, // Set to true to always show the scrollbar
            child: ListView.builder(
              itemCount: sortedMatches.length,
              itemBuilder: (context, index) {
                final match = sortedMatches[index];
                return PhaseMatchResultItem(
                  match: match,
                  backgroundColor: index.isEven ? Colors.transparent : Colors.transparent,
                  isLastItem: index == sortedMatches.length - 1, // Check if it's the last item
                  isFirstItem: index == sortedMatches.first,
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
