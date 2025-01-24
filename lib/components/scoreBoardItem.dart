import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/models/Club.dart';
import 'package:untitled/screens/teamPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Team.dart';
import '../models/Match.dart';
import 'colors.dart'; // Import this for Timer

class ScoreboardItem extends StatefulWidget {
  final Match match;
  final Function(Club) onTeamSelected;

  const ScoreboardItem({
    Key? key,
    required this.match,
    required this.onTeamSelected,
  }) : super(key: key);

  @override
  _ScoreboardItemState createState() => _ScoreboardItemState();
}

class _ScoreboardItemState extends State<ScoreboardItem> {
  bool isFavoriteHome = false; // Track favorite state for home team
  bool isFavoriteAway = false; // Track favorite state for away team
  List<String?> favoriteTeams = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favoriteTeams = prefs.getStringList('favoriteTeams') ?? [];
    String homeID = widget.match.home!.id.toString();
    String awayID = widget.match.away!.id.toString();

    bool homeExists = favoriteTeams.contains(homeID);
    bool awayExists = favoriteTeams.contains(awayID);
    // Check if the teams are already marked as favorites
    setState(() {
      isFavoriteHome = homeExists;
      isFavoriteAway = awayExists;
    });
  }

  Future<void> _toggleFavorite(bool isHome) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get current favorite teams list
    List<String> favoriteTeams = prefs.getStringList('favoriteTeams') ?? [];

    setState(() {
      if (isHome) {
        isFavoriteHome = !isFavoriteHome; // Toggle favorite state for home team

        if (isFavoriteHome) {
          // Check if home team already exists in favorites
          if (!favoriteTeams.contains(widget.match.home!.id.toString())) {
            // Add home team to favorites if it is now a favorite
            favoriteTeams.add(widget.match.home!.id.toString());
          }
        } else {
          // Remove home team from favorites if it is no longer a favorite
          favoriteTeams.remove(widget.match.home!.id.toString());
        }
      } else {
        isFavoriteAway = !isFavoriteAway; // Toggle favorite state for away team

        if (isFavoriteAway) {
          // Check if away team already exists in favorites
          if (!favoriteTeams.contains(widget.match.away!.id.toString())) {
            // Add away team to favorites if it is now a favorite
            favoriteTeams.add(widget.match.away!.id.toString());
          }
        } else {
          // Remove away team from favorites if it is no longer a favorite
          favoriteTeams.remove(widget.match.away!.id.toString());
        }
      }
    });

    // Save the updated favorite teams list
    await prefs.setStringList('favoriteTeams', favoriteTeams);
    print('Updated Favorite Teams: $favoriteTeams'); // Debugging line to confirm saved data
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.156,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // First team details (logo and name)
            _buildTeamInfo(context, widget.match.home!, true),

            // Middle content: match score and play/pause buttons
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Column(
                children: [
                  SizedBox(height: 7),
                  _buildMatchDetails(context),
                ],
              ),
            ),
            // Second team details (logo and name)
            _buildTeamInfo(context, widget.match.away!, false),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamInfo(BuildContext context, Club team, bool isHome) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.star,
            color: isHome
                ? (isFavoriteHome ? AppColors.favoriteIcon : Colors.grey)
                : (isFavoriteAway ? AppColors.favoriteIcon : Colors.grey),
          ),
          onPressed: () async {
            // Call the method to toggle favorite state
            await _toggleFavorite(isHome);
          },
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.075,
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: AppColors.matchItemComponentTeamLogoBorder, width: 2),
          ),
          child: GestureDetector(
            onTap: () {
              widget.onTeamSelected(team);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                team.logo??'',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 130,
          child: Text(
            team.name,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  Widget _buildMatchDetails(BuildContext context) {
    return Container(
      child: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        removeTop: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${widget.match.date != null ? DateFormat('dd-MM-yyyy').format(widget.match.date!) : 'TBD'}",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15),
            ),
            Text(
              "VS",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
            ),
            MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              removeTop: true,
              child: Row(
                children: [
                  Text(
                    (widget.match.home_first_half_score! + widget.match.home_second_half_score!).toString(),
                    style: TextStyle(fontSize: 27.0, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 30),
                  Text(
                    "-",
                    style: TextStyle(fontSize: 27.0, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 30),
                  Text(
                    (widget.match.away_first_half_score! + widget.match.away_second_half_score!).toString(),
                    style: TextStyle(fontSize: 27.0, color: Colors.black, fontWeight: FontWeight.bold),
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
