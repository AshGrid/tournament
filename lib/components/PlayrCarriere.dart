import 'package:flutter/material.dart';
import '../Service/data_service.dart';
import '../models/Player.dart';
import '../models/Season.dart';
import '../models/Club.dart'; // Import the Club model

class PlayerCareer extends StatefulWidget {
  final Player player;

  const PlayerCareer({Key? key, required this.player}) : super(key: key);

  @override
  _PlayerCareerState createState() => _PlayerCareerState();
}

class _PlayerCareerState extends State<PlayerCareer> {
  final DataService dataService = DataService();
  bool isSeasonsLoading = true;
  List<Season> seasonsList = [];
  Map<String, Player> seasonStats = {}; // Map to store stats per season
  Map<String, Club> clubs = {}; // Map to store clubs based on their ID


  // Fetching seasons data
  Future<void> _fetchSeasons() async {
    try {
      // Fetch all seasons
      final fetchedSeasons = await dataService.fetchSeasons();

      // Filter seasons where the player's club ID matches a club in the season's teams list
      final filteredSeasons = fetchedSeasons.where((season) {
        return season.teams?.any((club) => club.id == widget.player.club) ?? false;
      }).toList();

      setState(() {
        seasonsList = filteredSeasons;
        isSeasonsLoading = false;
      });

      // Fetch player stats for the filtered seasons
      for (var season in filteredSeasons) {
        print("Filtered Season ID: ${season.id}");
        await _fetchPlayerStatsForSeason(season);
      }
    } catch (e) {
      print('Error fetching or filtering seasons: $e');
    }
  }


  // Fetch player stats for a specific season and club info
  Future<void> _fetchPlayerStatsForSeason(Season season) async {
    try {
      final stats = await dataService.fetchPlayer(widget.player.id!, season.id!);

      // Fetch the club info based on the club ID in the stats
      final club = await dataService.fetchClub(stats.club!); // Assuming clubId exists in the player stats

      setState(() {
        seasonStats[season.id.toString()] = stats;
        clubs[stats.club.toString()] = club; // Store the club data
      });

      print('Fetched stats for season ${season.id}: $stats');
      print('Fetched club for season ${season.id}: $club');
    } catch (e) {
      print('Error fetching stats or club for season ${season.id}: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSeasons();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: 50, child: Text(' ', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                        SizedBox(width: 30, child: Text(' ', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                        SizedBox(width: 35, child: Text(' ', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                        SizedBox(width: 30, child: Text('MJ', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                        SizedBox(width: 30, child: Text('G', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                        SizedBox(width: 30, child: Text('A', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                        SizedBox(width: 30, child: Text('CJ', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                        SizedBox(width: 30, child: Text('CR', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                  Divider(),
                  isSeasonsLoading
                      ? Center(child: CircularProgressIndicator(color: Colors.white,)) // Loading indicator while seasons are being fetched
                      : SizedBox(
                    height: (seasonsList.length+1) * 70.0, // Limit the height of the ListView
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: seasonsList.length,
                      itemBuilder: (context, index) {
                        final season = seasonsList[index];

                        // Fetch player stats for the current season
                        final stats = seasonStats[season.id.toString()];
                        final club = clubs[stats?.club.toString()]; // Get the club using clubId

                        // If stats or club info is not yet available, show loading
                        if (stats == null || club == null) {
                          return Center(child: CircularProgressIndicator(color: Colors.red,));
                        }

                        // Render the player's stats for this season
                        return Container(
                          height: 70.0, // Fixed height for each stat row
                          color: Colors.white, // Background color for each season row
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(width: 50, child: Text(season.season ?? '', textAlign: TextAlign.left, style: TextStyle(fontSize: 9))),
                                // Assuming you fetch the club logo based on the club ID
                                SizedBox(
                                  width: 30,
                                  child: Image.network(
                                    club.logo ?? '', // Use the club's logo URL
                                   // fit: BoxFit.none,
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                                SizedBox(width: 35, child: Text(club.name, textAlign: TextAlign.right, style: TextStyle(fontSize: 8.5))),
                                SizedBox(width: 30, child: Text(stats.matches_played.toString(), textAlign: TextAlign.right)),
                                SizedBox(width: 30, child: Text(stats.goals.toString(), textAlign: TextAlign.center)),
                                SizedBox(width: 30, child: Text(stats.assists.toString(), textAlign: TextAlign.center)),
                                SizedBox(width: 30, child: Text(stats.yellow_cards.toString(), textAlign: TextAlign.center)),
                                SizedBox(width: 30, child: Text(stats.red_cards.toString(), textAlign: TextAlign.center)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
