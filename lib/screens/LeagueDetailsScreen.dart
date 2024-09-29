import 'package:flutter/material.dart';
import 'package:untitled/components/ads_banner.dart';
import 'package:untitled/models/league.dart';
import 'package:untitled/screens/phaseDetailsScreen.dart';
import '../components/colors.dart';
import '../components/image_slider.dart';
 // Import the PhaseDetailsScreen

class LeagueDetailsScreen extends StatelessWidget {
  final League league;

  const LeagueDetailsScreen({super.key, required this.league});

  @override
  Widget build(BuildContext context) {
    // Static list of phases for demonstration
    final List<String> phases = [
      'Phase de Poule',
      'Quart de Finale',
      'Demi-Finale',
      'Finale',
    ];


    // Static list of images for demonstration
    List<String> imagePath = [
      'assets/images/image1.jpeg',
      'assets/images/image2.jpeg',
      'assets/images/image1.jpeg',
    ];

    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      body: CustomScrollView(
        slivers: [
          // Big Container with League Name and Logo
          SliverToBoxAdapter(
            child: Container(
              height: 350,
              margin: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColors.trophyComponent,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.transparent.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // League Name and Logo in the first container
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: AppColors.trophyTitleComponent,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.transparent.withOpacity(0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // League Image in a rounded container
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(color: Colors.black12, width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 4,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/${league.leagueName.toUpperCase()}.png',
                                fit: BoxFit.contain,
                                width: 80,
                                height: 80,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // League Name
                        Expanded(
                          child: Text(
                            league.leagueName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // List of Phases in the second container
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: phases.length,
                      itemBuilder: (context, index) {
                        // Alternate background colors
                        final backgroundColor = index.isEven ? AppColors.trophyItem1 : Colors.transparent;

                        return GestureDetector(
                          onTap: () {
                            // Navigate to PhaseDetailsScreen when a phase is selected
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PhaseDetailsScreen(phaseName: phases[index]),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: const BorderSide(color: AppColors.trophyListTileItemBorder, width: 2),
                                  top: index == 0
                                      ? const BorderSide(color: AppColors.trophyListTileItemBorder, width: 2)
                                      : BorderSide.none,
                                ),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                                title: Text(
                                  phases[index],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    fontFamily: "oswald",
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20), // Space between the big container and the grid
          ),
          // Dynamic Image Grid
          SliverToBoxAdapter(
            child: AdsBanner()
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20), // Space between the big container and the grid
          ),
          // Dynamic Image Grid
          SliverToBoxAdapter(
            child: ImageSlider(
              imagePaths: imagePath,
            ),
          ),
        ],
      ),
    );
  }
}
