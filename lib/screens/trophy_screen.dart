import 'package:flutter/material.dart';
import 'package:untitled/Service/mock_data.dart';

import '../components/image_slider.dart'; // Your image slider component
import '../components/colors.dart'; // Import your custom colors
import '../models/League.dart'; // League model
import 'package:flutter/services.dart' show rootBundle;

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


    Future<String> getLeagueImage(String leagueName) async {
      String lowerCasePath = 'assets/images/${leagueName.toLowerCase()}.png';
      String upperCasePath = 'assets/images/${leagueName.toUpperCase()}.png';

      // Check if the lowercase version exists
      try {
        await rootBundle.load(lowerCasePath);
        return lowerCasePath;
      } catch (e) {
        // If not, check if the uppercase version exists
        try {
          await rootBundle.load(upperCasePath);
          return upperCasePath;
        } catch (e) {
          // Handle the case where neither file exists
          throw Exception('Image not found for league $leagueName');
        }
      }
    }

    // Static list of leagues for demonstration
    final List<League> leagues = MockData.mockLeagues;

    final List<League> leaguesIT = MockData.mockLeaguesIT;
    final List<League> tropheeVeteran = MockData.mockLeaguesVeterans;
    final List<League> tropheeCorporate = MockData.mockLeaguesCorporate;

    List<String> imagePath = [
      'assets/images/image1.jpeg',
      'assets/images/image2.jpeg',
      'assets/images/image1.jpeg',
    ];
     double height = 300;
     trophyName.toUpperCase()== "TROPHÉES DE CARTHAGE" ? height = 430 : trophyName.toUpperCase()== "TROPHÉES IT" ? height=300: 200 ;

    return Scaffold(
      backgroundColor: AppColors.secondaryBackground, // Custom background color

      body: CustomScrollView(
        slivers: [
          // Big Container with Trophy Name and Logo
          SliverToBoxAdapter(
            child: Container(
              height: height,
              margin: const EdgeInsets.only(left: 12,right: 12,top: 12,bottom: 12),
              padding: const EdgeInsets.only(left: 0,right: 0,top: 0,bottom: 0),
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
                          margin: EdgeInsets.only(bottom: 0,left: 12,right: 12,top: 0),
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
                                'assets/images/${trophyName.toUpperCase()}.png', // Adjust path
                                fit: BoxFit.contain,
                                width: 80,
                                height: 80,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 2),
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

                  // List of Leagues in the second container
                  SizedBox(
                    height: height-130, // Adjust height if needed
                    child: ListView.builder(
                      itemCount:trophyName.toUpperCase() == "TROPHÉES IT" ? leaguesIT.length : trophyName.toUpperCase()  == "TROPHÉES VÉTERANS" ? tropheeVeteran.length :  trophyName.toUpperCase()  == "TROPHÉES DE CARTHAGE" ? leagues.length : tropheeCorporate.length,
                      itemBuilder: (context, index) {
                        final league = trophyName.toUpperCase() == "TROPHÉES IT" ? leaguesIT[index] : trophyName.toUpperCase()  == "TROPHÉES VÉTERANS" ? tropheeVeteran[index] : trophyName.toUpperCase()  == "TROPHÉES DE CARTHAGE" ? leagues[index] : tropheeCorporate[index] ;
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
                              contentPadding: const EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
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
                                    "assets/images/${league.name!.toUpperCase()}.png",
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              title: Text(
                                league.name!.toUpperCase(),
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
