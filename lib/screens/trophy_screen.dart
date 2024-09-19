import 'package:flutter/material.dart';

import '../components/image_slider.dart';
 // Import your Trophy model
import '../components/colors.dart'; // Import your custom colors
import '../models/league.dart'; // Import your League model
// Import your DynamicImageGrid component

class TrophyScreen extends StatelessWidget {
  final String trophyName;

  const TrophyScreen({super.key, required this.trophyName});

  @override
  Widget build(BuildContext context) {
    // Static list of leagues for demonstration
    final List<League> leagues = [
      League(
        leagueName: 'League Samedi',
        leagueLogo: 'assets/images/LIGUE SAMEDI.png',
        matches: [],
      ),
      League(
        leagueName: 'League Dimanche',
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
      // Add more leagues here
    ];

    List<String> imagePath = [
      'assets/images/image1.jpeg',
      'assets/images/image2.jpeg',
      'assets/images/image1.jpeg',
    ];

    return Scaffold(
      backgroundColor: AppColors.secondaryBackground, // Use your gradient or background color

      body: CustomScrollView(
        slivers: [
          // Big Container with Trophy Name and Logo
          SliverToBoxAdapter(
            child: Container(
              height: 350,
              margin: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColors.trophyComponent, // Use your component background color
                borderRadius: BorderRadius.circular(12.0), // Round the corners
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
                  // Trophy Name and Logo in the first container
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: AppColors.trophyTitleComponent, // Light grey background for the box
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
                        // Trophy Image in a rounded container
                        Container(
                          width: 100, // Container size
                          height: 100, // Container size
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
                                'assets/images/${trophyName}.png', // Adjust path as needed
                                fit: BoxFit.contain, // Ensure the image fits inside
                                width: 80, // Image size
                                height: 80, // Image size
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Trophy Name
                        Expanded(
                          child: Text(
                            trophyName,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                 // const SizedBox(height: 8),
                  // List of Leagues in the second container
                  SizedBox(
                    height: 200, // Adjust height if needed
                    child: ListView.builder(
                      itemCount: leagues.length,
                      itemBuilder: (context, index) {
                        final league = leagues[index];
                        // Alternate background colors
                        final backgroundColor = index.isEven ? AppColors.trophyItem1 : Colors.transparent;

                        return Container(
                          //margin: const EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(

                              border: Border(
                                bottom: const BorderSide(color: AppColors.trophyListTileItemBorder, width: 2),
                                top: index==0 ? BorderSide(color: AppColors.trophyListTileItemBorder, width: 2) : BorderSide.none,
                              ),

                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                              leading: Container(
                                width: 55, // Box width
                                height: 55, // Box height
                                decoration: BoxDecoration(
                                  color: Colors.white, // Background color for the box
                                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
                                  border: Border.all(
                                    color: AppColors.bottomSheetLogo, // Border color
                                    width: 1.0, // Border width
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.25), // Shadow color
                                      blurRadius: 4.0, // Blur radius
                                      spreadRadius: 0.0, // Spread radius
                                      offset: const Offset(0, 4), // Shadow position
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0), // Padding inside the box
                                  child: Image.asset(
                                    league.leagueLogo, // Adjust path as needed
                                    fit: BoxFit.scaleDown, // Adjust image fit

                                  ),
                                ),
                              ),
                              title: Text(
                                league.leagueName,
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: "oswald"),

                              ),
                              onTap: () {
                                // Handle tap event if needed
                              },
                            ),
                          )
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
          // Optional: Ads Banner

        ],
      ),
    );
  }
}
