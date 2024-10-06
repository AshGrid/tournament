import 'package:flutter/material.dart';

import '../components/image_slider.dart'; // Your image slider component
import '../components/colors.dart'; // Import your custom colors
import '../models/league.dart'; // League model

class TrophyScreen extends StatelessWidget {
  final String trophyName;
  final void Function(League league) onLeagueSelected;

  const TrophyScreen({
    super.key,
    required this.trophyName,
    required this.onLeagueSelected, // Assigning the callback
  });

  @override
  Widget build(BuildContext context) {
    // Static list of leagues for demonstration
    final List<League> leagues = [
      League(
        leagueName: 'Ligue Samedi',
        leagueLogo: 'assets/images/LIGUE SAMEDI.png',
        matches: [],
      ),
      League(
        leagueName: 'Ligue Dimanche',
        leagueLogo: 'assets/images/LIGUE DIMANCHE.png',
        matches: [],
      ),
      League(
        leagueName: 'Coupe Samedi',
        leagueLogo: 'assets/images/COUPE SAMEDI.png',
        matches: [],
      ),
      League(
        leagueName: 'Coupe Dimanche',
        leagueLogo: 'assets/images/COUPE DIMANCHE.png',
        matches: [],
      ),
    ];

    final List<League> leaguesIT = [
      League(
        leagueName: 'Ligue IT',
        leagueLogo: 'assets/images/LIGUE SAMEDI.png',
        matches: [],
      ),
      League(
        leagueName: 'Coupe IT',
        leagueLogo: 'assets/images/LIGUE DIMANCHE.png',
        matches: [],
      ),

    ];
    final List<League> tropheeVeteran = [
    League(
    leagueName: 'Ligue Veterans',
    leagueLogo: 'assets/images/LIGUE SAMEDI.png',
    matches: [],
    ),
    League(
    leagueName: 'Coupe Veterans',
    leagueLogo: 'assets/images/LIGUE DIMANCHE.png',
    matches: [],
    ),

    ];

    List<String> imagePath = [
      'assets/images/image1.jpeg',
      'assets/images/image2.jpeg',
      'assets/images/image1.jpeg',
    ];



    return Scaffold(
      backgroundColor: AppColors.secondaryBackground, // Custom background color

      body: CustomScrollView(
        slivers: [
          // Big Container with Trophy Name and Logo
          SliverToBoxAdapter(
            child: Container(
              height: 350,
              margin: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColors.trophyComponent, // Use your component background color
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Trophy Name and Logo in the first container
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: AppColors.trophyTitleComponent, // Light background
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Trophy Image in a rounded container
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white, // Background color of the container
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
                                'assets/images/$trophyName.png', // Adjust path
                                fit: BoxFit.contain,
                                width: 80,
                                height: 80,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Trophy Name
                        Expanded(
                          child: Text(
                            trophyName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // List of Leagues in the second container
                  SizedBox(
                    height: 200, // Adjust height if needed
                    child: ListView.builder(
                      itemCount:trophyName == "TROPHEES IT" ? leaguesIT.length : trophyName == "TROPHEES VETERANS" ? tropheeVeteran.length :  trophyName == "TROPHEES DE CARTHAGE" ? leagues.length : leagues.length,
                      itemBuilder: (context, index) {
                        final league = trophyName == "TROPHEES IT" ? leaguesIT[index] : trophyName == "TROPHEES VETERANS" ? tropheeVeteran[index] : trophyName == "TROPHEES DE CARTHAGE" ? leagues[index] : leagues[index] ;
                        final backgroundColor = index.isEven ? AppColors.trophyItem1 : Colors.transparent;

                        return Container(
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: const BorderSide(
                                  color: AppColors.trophyListTileItemBorder,
                                  width: 2,
                                ),
                                top: index == 0
                                    ? const BorderSide(
                                  color: AppColors.trophyListTileItemBorder,
                                  width: 2,
                                )
                                    : BorderSide.none,
                              ),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 8.0,
                              ),
                              leading: Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(
                                    color: AppColors.bottomSheetLogo,
                                    width: 1.0,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      blurRadius: 4.0,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Image.asset(
                                    league.leagueLogo,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              title: Text(
                                league.leagueName,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: "oswald",
                                ),
                              ),
                              onTap: () {
                                onLeagueSelected(league); // Call the callback
                              },
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
            child: ImageSlider(
              imagePaths: imagePath,
            ),
          ),
        ],
      ),
    );
  }
}
