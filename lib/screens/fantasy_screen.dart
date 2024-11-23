import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Service/data_service.dart';
import '../components/matchItemFavorite.dart';
import '../models/Match.dart';

class FantasyScreen extends StatefulWidget {
  final Function(Match) onMatchSelected;
  const FantasyScreen({Key? key, required this.onMatchSelected}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FantasyScreen> {
  final DataService dataService = DataService();
  List<Match> matchesList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMatches();
  }

  Future<void> _fetchMatches() async {
    setState(() {
      isLoading = true;
    });

    try {
      final fetchedMatches = await dataService.fetchLiveMatches();
      matchesList = fetchedMatches;
    } catch (e) {
      print('Error fetching matches: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isLoading)
          const Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )
        else if (matchesList.isEmpty)
          const Expanded(
            child: Center(
              child: Text(
                'Pas de matches ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              itemCount: matchesList.length,
              itemBuilder: (context, index) {
                final match = matchesList[index];
                return GestureDetector(
                  onTap: () {
                    widget.onMatchSelected(match);
                  },
                  child: MatchItemFavorite(
                    match: match,
                    isFirstItem: index == 0,
                    isLastItem: index == matchesList.length - 1,
                    backgroundColor: Colors.transparent,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
