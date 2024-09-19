import 'package:flutter/material.dart';
import 'package:untitled/components/colors.dart';

class MatchResultComponent extends StatelessWidget {
  final List<MatchResult> matchResults;

  const MatchResultComponent({
    Key? key,
    required this.matchResults,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title with underline and shadow effect
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dernier Résultat',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 4.0,
                        color: AppColors.textShadow,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2), // Space between text and underline
                Container(
                  width: 200, // Adjust width for the underline
                  height: 3, // Thickness of the underline
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.textShadow,
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 4), // Shadow position for underline
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Horizontal list of match results
          SizedBox(
            height: 192, // Set consistent height for the component
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: matchResults.length,
              itemBuilder: (context, index) {
                final result = matchResults[index];
                return Container(
                  height: 175,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                  width: 240, // Width consistent across items
                  decoration: BoxDecoration(
                    gradient: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: AppColors.matchResultBorder, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.matchResultShadow,
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, -7),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            result.dateTime,
                            style: const TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 3.0,
                                  color: AppColors.textShadow,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      // Match info
                      SizedBox(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Team 1 details
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                        color: AppColors.teamLogoShadow,
                                        width: 1,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(4.0),
                                    child: Image.asset(
                                      "assets/images/${result.team1Name}.jpg",
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    result.team1Name,
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 4.0,
                                          color: AppColors.textShadow,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            // "vs" text
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'vs',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "oswald",
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    result.result,
                                    style: const TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            // Team 2 details
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                        color: AppColors.teamLogoShadow,
                                        width: 1,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(4.0),
                                    child: Image.asset(
                                      "assets/images/${result.team2Name}.jpg",
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    result.team2Name,
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 4.0,
                                          color: AppColors.textShadow,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      // Stadium info
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 50,
                                width: 50, // Image size is controlled here
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 8, // Adjust this to control shadow horizontal position relative to the image
                                      top: 30,  // Adjust this to control shadow vertical position
                                      child: Container(
                                        width: 30, // Control shadow width
                                        height: 3, // Control shadow height
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              spreadRadius: 1.0, // How much the shadow spreads beyond the box
                                              blurRadius: 5.0,   // Control the softness of the shadow
                                              color: AppColors.textShadow,
                                              offset: Offset(2, 2), // Adjust shadow's x (width) and y (height) positions
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Image.asset(
                                      "assets/images/stadium.png",
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 6.0),
                              Flexible(
                                child: Text(
                                  result.stadiumName,
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "oswald",
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 4.0,

                                        color: AppColors.textShadow,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MatchResult {
  final String team1Logo;
  final String team2Logo;
  final String team1Name;
  final String team2Name;
  final String result;
  final String dateTime;
  final String stadiumName;

  MatchResult({
    required this.team1Logo,
    required this.team2Logo,
    required this.team1Name,
    required this.team2Name,
    required this.result,
    required this.dateTime,
    required this.stadiumName,
  });
}
