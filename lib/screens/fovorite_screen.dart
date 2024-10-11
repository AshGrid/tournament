import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Service/data_service.dart';
import '../components/colors.dart';
import '../components/leagueFavoriteComponent.dart';
import '../models/Team.dart';
import '../models/League.dart';
import '../models/Match.dart';
import '../Service/mock_data.dart'; // Import your mock data

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final matchesGroupedByDate = MockData.mockLeagues;
  final DataService dataService = DataService();
  List<Match> matchesList = [];
  @override
  void initState() {
    super.initState();
    _fetchMatches();
  }
  Future<void> _fetchMatches() async {
    final fetchedMatches = await dataService.fetchPlayedMatches();
    setState(() {
      matchesList = fetchedMatches;

    });
  }


  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        // Horizontally scrollable container for days (if needed, add this here),

        // Vertically scrollable container for leagues
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 0, right: 0, top: 8, bottom: 7),
            itemCount: matchesGroupedByDate.length,
            itemBuilder: (context, index) {
              //final date = matchesGroupedByDate[index].matches.first.date;
              final league = matchesGroupedByDate[index];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display formatted date
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        //DateFormat('MMMM d, yyyy').format(matchesList[index].date!),
                        DateFormat('MMMM d, yyyy').format(DateTime.now()),
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 3.0,
                              color: AppColors.textShadow,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // League component
                     LeagueFavoriteComponent(league: league)
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}