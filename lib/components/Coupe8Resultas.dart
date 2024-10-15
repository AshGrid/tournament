import 'package:flutter/material.dart';
import 'package:untitled/components/phaseMatchResultItem.dart';
import 'package:untitled/models/Coupe.dart';
import 'package:untitled/models/Coupe8.dart';
import '../models/Match.dart';
import 'image_slider.dart';

class Coupe8Resultats extends StatefulWidget {
  final Coupe8 coupe;
  const Coupe8Resultats({Key? key, required this.coupe}) : super(key: key);

  @override
  _Coupe8ResultatsState createState() => _Coupe8ResultatsState();
}

class _Coupe8ResultatsState extends State<Coupe8Resultats> {
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

  @override
  Widget build(BuildContext context) {
    // Collect matches from Coupe8 based on the phase selected
    List<Match?> sortedMatches = [];

    switch (phases[selectedDayIndex]) {
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
          widget.coupe.finalMatch,
        ].where((match) => match?.is_ended == true).toList(); // Filter matches that are ended
        break;
    }

    // Sort matches based on their live status


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
