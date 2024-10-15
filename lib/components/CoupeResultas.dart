import 'package:flutter/material.dart';
import 'package:untitled/components/phaseMatchResultItem.dart';
import 'package:untitled/models/Coupe.dart';
import '../Service/mock_data.dart';
import '../models/Match.dart';
import 'image_slider.dart';

class CoupeResultats extends StatefulWidget {
  final Coupe coupe;
  const CoupeResultats({Key? key, required this.coupe}) : super(key: key);

  @override
  _CoupeResultatsState createState() => _CoupeResultatsState();
}

class _CoupeResultatsState extends State<CoupeResultats> {
  int selectedDayIndex = 0;

  final List<String> phases = [
    'round 1',
    'Quarterfinals',
    'Semifinals',
    'Final',
  ];

  List<String> imagePath = [
    'assets/images/image1.jpeg',
    'assets/images/image2.jpeg',
    'assets/images/image1.jpeg',
  ];

  @override
  Widget build(BuildContext context) {

    List<Match?> sortedMatches = [];

    switch (phases[selectedDayIndex]) {
      case 'round 1':
        sortedMatches = [
          widget.coupe.round_1,
          widget.coupe.round_2,
          widget.coupe.round_3,
          widget.coupe.round_4,
          widget.coupe.round_5,
          widget.coupe.round_6,
          widget.coupe.round_7,
          widget.coupe.round_8,
        ].where((match) => match?.is_ended == true).toList(); // Filter matches that are ended
        break;
      case 'Quarterfinals':
        sortedMatches = [
          widget.coupe.quarter_final_1,
          widget.coupe.quarter_final_2,
          widget.coupe.quarter_final_3,
          widget.coupe.quarter_final_4,
        ].where((match) => match?.is_ended == true).toList(); // Filter matches that are ended
        break;
      case 'Semifinals':
        sortedMatches = [
          widget.coupe.semi_final_1,
          widget.coupe.semi_final_2,
        ].where((match) => match?.is_ended == true).toList(); // Filter matches that are ended
        break;
      case 'Final':
        sortedMatches = [
          widget.coupe.finalmatch,
        ].where((match) => match?.is_ended == true).toList(); // Filter matches that are ended
        break;
    }


    // Create a list of matches from the Coupe object

    // Filter matches that are ended


    // Organize matches by phase





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
          height: MediaQuery.of(context).size.height * 0.6, // Adjust the height as needed
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
                  isLastItem: index == sortedMatches.length - 1,
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
