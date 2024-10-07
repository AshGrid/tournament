import 'package:flutter/material.dart';
import 'package:untitled/components/phaseMatchResultItem.dart';
import '../models/Team.dart';
import '../models/match.dart';
import 'image_slider.dart';

class Tropheehannibalresultats extends StatefulWidget {
  const Tropheehannibalresultats({Key? key}) : super(key: key);

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<Tropheehannibalresultats> {
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
  Map<String, List<Match>> matchesByPhase = {
    'Quarterfinals': [
      Match(homeTeam: Team(name: 'Ennakl', rank: 1, matchesPlayed: 12, goals: 15, points: 25, logo: 'assets/images/ennakl.jpg'), awayTeam:Team(name: 'Ennakl', rank: 1, matchesPlayed: 12, goals: 15, points: 25, logo: 'assets/images/ennakl.jpg'), homeScore: 1, awayScore: 2, matchStatus: 'finished', matchTime: '19:00', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/ennakl.jpg'),
      Match(homeTeam: Team(name: 'Ennakl', rank: 1, matchesPlayed: 12, goals: 15, points: 25, logo: 'assets/images/ennakl.jpg'), awayTeam: Team(name: 'Ennakl', rank: 1, matchesPlayed: 12, goals: 15, points: 25, logo: 'assets/images/ennakl.jpg'), homeScore: 1, awayScore: 2, matchStatus: 'finished', matchTime: '19:00', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/ennakl.jpg'),
      Match(homeTeam: Team(name: 'Ennakl', rank: 1, matchesPlayed: 12, goals: 15, points: 25, logo: 'assets/images/ennakl.jpg'), awayTeam: Team(name: 'Ennakl', rank: 1, matchesPlayed: 12, goals: 15, points: 25, logo: 'assets/images/ennakl.jpg'), homeScore: 1, awayScore: 2, matchStatus: 'finished', matchTime: '19:00', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/ennakl.jpg'),
      Match(homeTeam: Team(name: 'Ennakl', rank: 1, matchesPlayed: 12, goals: 15, points: 25, logo: 'assets/images/ennakl.jpg'), awayTeam: Team(name: 'Ennakl', rank: 1, matchesPlayed: 12, goals: 15, points: 25, logo: 'assets/images/ennakl.jpg'), homeScore: 1, awayScore: 2, matchStatus: 'finished', matchTime: '19:00', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/ennakl.jpg'),
      // Add more quarterfinal matches here...
    ],
    'Semifinals': [
      Match(homeTeam: Team(name: 'Ennakl', rank: 1, matchesPlayed: 12, goals: 15, points: 25, logo: 'assets/images/ennakl.jpg'),awayTeam: Team(name: 'Ennakl', rank: 1, matchesPlayed: 12, goals: 15, points: 25, logo: 'assets/images/ennakl.jpg'), homeScore: 0, awayScore: 3, matchStatus: 'finished', matchTime: '21:00', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/ennakl.jpg'),
      Match(homeTeam: Team(name: 'Ennakl', rank: 1, matchesPlayed: 12, goals: 15, points: 25, logo: 'assets/images/ennakl.jpg'), awayTeam:Team(name: 'Ennakl', rank: 1, matchesPlayed: 12, goals: 15, points: 25, logo: 'assets/images/ennakl.jpg'), homeScore: 1, awayScore: 2, matchStatus: 'finished', matchTime: '19:00', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/ennakl.jpg'),
      // Add more semifinal matches here...
    ],
    'Final': [
      Match(homeTeam: Team(name: 'Ennakl', rank: 1, matchesPlayed: 12, goals: 15, points: 25, logo: 'assets/images/ennakl.jpg'),awayTeam:Team(name: 'Ennakl', rank: 1, matchesPlayed: 12, goals: 15, points: 25, logo: 'assets/images/ennakl.jpg'), homeScore: 2, awayScore: 1, matchStatus: 'live', matchTime: '20:00', homeTeamLogo: 'assets/images/ennakl.jpg', awayTeamLogo: 'assets/images/ennakl.jpg'),
      // Add more final matches here...
    ],
  };

  @override
  Widget build(BuildContext context) {
    List<Match> sortedMatches = matchesByPhase[phases[selectedDayIndex]] ?? [];

    sortedMatches.sort((a, b) {
      bool aIsLive = a.matchStatus.toLowerCase() == 'live';
      bool bIsLive = b.matchStatus.toLowerCase() == 'live';

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
          height: MediaQuery.of(context).size.height * 0.6, // Adjust the height as needed
          width: MediaQuery.of(context).size.width,
          child: Scrollbar(
            // Add scrollbar here
            thickness: 4.0, // Adjust thickness as needed
            child: ListView.builder(
              itemCount: sortedMatches.length,
              itemBuilder: (context, index) {
                final match = sortedMatches[index];
                return PhaseMatchResultItem(
                  match: match,
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
