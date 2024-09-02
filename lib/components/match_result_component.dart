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
          Text(
            'Dernier Résultat',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
              decorationThickness: 1.0,
            ),
          ),
          SizedBox(
            height: 180, // Increased height to accommodate larger logos
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: matchResults.length,
              itemBuilder: (context, index) {
                final result = matchResults[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  width: 240, // Increased width for larger boxes
                  decoration: BoxDecoration(
                    gradient: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            result.dateTime,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 90, // Adjusted height for larger logos
                        child: Column(
                          children: [
                            Text(
                              'vs',
                              style: TextStyle(
                                fontSize: 18.0, // Increased size of "vs"
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  result.team1Logo,
                                  height: 50, // Increased logo size
                                  width: 50, // Increased logo size
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  result.result,
                                  style: TextStyle(
                                    fontSize: 22.0, // Increased font size of the result
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Image.asset(
                                  result.team2Logo,
                                  height: 50, // Increased logo size
                                  width: 50, // Increased logo size
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            result.stadiumName,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
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
  final String result;
  final String dateTime;
  final String stadiumName;

  MatchResult({
    required this.team1Logo,
    required this.team2Logo,
    required this.result,
    required this.dateTime,
    required this.stadiumName,
  });
}
