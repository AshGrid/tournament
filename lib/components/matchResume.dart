import 'package:flutter/material.dart';
import '../Service/data_service.dart';
import '../models/Card.dart'; // Import your Card model
import '../models/Club.dart';
import '../models/Goal.dart'; // Import your Goal model
import '../models/Penalty.dart';
import '../models/Player.dart';
import '../models/PlayerChange.dart'; // Import your PlayerChange model
import '../models/Match.dart'; // Import your Match model
import '../models/Card.dart' as custom_card;

class MatchResume extends StatefulWidget {
  final Match match;

  const MatchResume({Key? key, required this.match}) : super(key: key);

  @override
  _MatchResumeState createState() => _MatchResumeState();
}

class _MatchResumeState extends State<MatchResume> {
  List<custom_card.Card> _cards = [];
  List<Goal> _goals = [];
  List<PlayerChange> _playerChanges = [];
  List<Penalty> _penalties = [];
  bool _isLoading = true; // Flag to track loading state

  final DataService dataService = DataService();

  @override
  void initState() {
    super.initState();
    _fetchMatchDetails();
  }

  Future<void> _fetchCardsList() async {
    final fetchedCards = await dataService.fetchCards(widget.match.id!);

    setState(() {
      _cards = fetchedCards;
    });
  }

  Future<void> _fetchPenaltiesList() async {
    final fetchedPenalties = await dataService.fetchPenalties(widget.match.id!);

    setState(() {
      _penalties = fetchedPenalties;
    });
  }

  Future<void> _fetchGoalsList() async {
    final fetchedGoals = await dataService.fetchGoals(widget.match.id!);

    setState(() {
      _goals = fetchedGoals;
    });
  }

  Future<void> _fetchPlayerChangeList() async {
    final fetchedPlayerChanges =
        await dataService.fetchPlayerChanges(widget.match.id!);

    setState(() {
      _playerChanges = fetchedPlayerChanges;
    });
  }

  Future<void> _fetchMatchDetails() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate delay
    _fetchCardsList();
    _fetchGoalsList();
    _fetchPlayerChangeList();
    _fetchPenaltiesList();

    setState(() {
      _isLoading = false; // Set loading to false after data is fetched
    });
  }


  List<dynamic> parseTime(String timeString) {
    if (timeString.contains('+')) {
      // Handle times with additional time, e.g., "25:00 + 5"
      List<String> parts = timeString.split('+');
      String baseTime = parts[0].trim(); // e.g., '25:00'
      int additionalMinutes = int.parse(parts[1].trim()); // e.g., 5

      // Parse base time (MM:SS)
      List<String> baseParts = baseTime.split(":");
      int minutes = int.parse(baseParts[0]);
      int seconds = int.parse(baseParts[1]);

      // Return a list containing Duration (base time) and additional minutes
      return [Duration(minutes: minutes, seconds: seconds), additionalMinutes];
    } else {
      // Handle regular MM:SS format
      List<String> baseParts = timeString.split(":");
      int minutes = int.parse(baseParts[0]);
      int seconds = int.parse(baseParts[1]);

      // Return base time with no additional minutes (represented as null)
      return [Duration(minutes: minutes, seconds: seconds), null];
    }
  }


  Duration _normalizeTime(String timeString) {
    // Check if the time string contains a '+'
    if (timeString.contains('+')) {
      // Split into base time and additional time
      List<String> parts = timeString.split('+');
      String baseTime = parts[0].trim(); // e.g., '25:00'
      // Ignoring the additional minutes for sorting purposes, treat baseTime as the event time.
      // We only care about the base time in terms of order, additional time can be ignored for sorting.

      // Parse base time (MM:SS)
      List<String> baseParts = baseTime.split(":");
      int minutes = int.parse(baseParts[0]);
      int seconds = int.parse(baseParts[1]);

      return Duration(minutes: minutes, seconds: seconds);
    } else {
      // Handle regular MM:SS format
      List<String> parts = timeString.split(":");
      int minutes = int.parse(parts[0]);
      int seconds = int.parse(parts[1]);

      return Duration(minutes: minutes, seconds: seconds);
    }
  }



  @override
  Widget build(BuildContext context) {
    List<Event> events = _combineEvents();
    //events.sort((a, b) => b.min!.compareTo(a.min!)); // Sort events by time
    // events.sort(
    //     (a, b) => _normalizeTime(b.min!).compareTo(_normalizeTime(a.min!)));

    events.sort((a, b) {
      List<dynamic> parsedA = parseTime(a.min!);
      List<dynamic> parsedB = parseTime(b.min!);

      Duration baseTimeA = parsedA[0];
      Duration baseTimeB = parsedB[0];

      // Compare base times first
      int baseComparison = baseTimeA.compareTo(baseTimeB);
      if (baseComparison != 0) {
        return baseComparison;
      }

      // If base times are equal, compare additional time (if exists)
      int? additionalA = parsedA[1];
      int? additionalB = parsedB[1];

      if (additionalA != null && additionalB != null) {
        return additionalA.compareTo(additionalB);
      } else if (additionalA != null) {
        return 1; // Extra time should come after base time
      } else if (additionalB != null) {
        return -1; // Base time comes before extra time
      }

      return 0; // Times are exactly the same
    });

    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: _isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator while fetching data
          : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return _buildEventRow(events[index]);
              },
            ),
    );
  }

  List<Event> _combineEvents() {
    List<Event> events = [];

    // Add goals
    for (var goal in _goals) {
      if (!goal.is_penalty!) {
        events.add(Event(
          id: goal.id,
          min: goal.min,
          type: 'goal',
          player: goal.player,
          assistPlayer: goal.assist,
          is_own_goal:  goal.is_own_goal,
          // Assuming Goal has assistPlayer
          team: goal.player?.club, // Assuming Player model has a club attribute
        ));
      }
      print("goal: ${goal.player?.club}");
    }

    // Add cards
    for (var card in _cards) {
      events.add(Event(
        id: card.id,
        min: card.min,
        type: card.type!.toLowerCase(),
        player: card.player,
        team: card.player?.club, // Assuming Player model has a club attribute
        second_yellow: card.second_yellow,
      ));
    }
    for (var penalty in _penalties) {
      events.add(Event(
        id: penalty.id,
        status: penalty.status,
        min: penalty.min == '116' ? '' : penalty.min,
        type: 'penalty',
        player: penalty.player,
        team:
            penalty.player?.club, // Assuming Player model has a club attribute
      ));
    }

    // Add player changes
    for (var change in _playerChanges) {
      events.add(Event(
        id: change.id,
        min: change.min,
        type: 'playerChange',
        playerOut: change.player_out,
        playerIn: change.player_in,
        team: change
            .player_out?.club, // Assuming Player model has a club attribute
      ));
    }

    return events;
  }

  Widget _buildEventRow(Event event) {
    String timeString = event.min ?? 'N/A';

    // Check if the event belongs to the home team or away team
    bool isHomeEvent = event.team == widget.match.home!.id; // Home team check
    bool isAwayEvent = event.team == widget.match.away!.id; // Away team check

    // Choose the appropriate icon for each event type
    Widget eventIcon;

    switch (event.type) {
      case 'goal':
        {
          if(event.is_own_goal == true){
        eventIcon = Image.asset(
        'assets/icons/owngoal.png', // Path to your custom icon
        width: 30,
        height: 30,
        );
        }
            else{ eventIcon = Image.asset(
            'assets/icons/ball.png', // Path to your custom icon
            width: 30,
            height: 30,
          );}

        }
        break;
      case 'yellow':
        print(event.id);
        print("yellow:  ${event.second_yellow}");
        if (event.second_yellow == true) {
          eventIcon = Image.asset(
            'assets/icons/red-yellow-card.png', // Path to your custom icon
            width: 38,
            height: 43,
          );
        } else {
          eventIcon = Image.asset(
            'assets/icons/yellowCard.png', // Path to your custom icon
            width: 38,
            height: 43,
          );
        }
        break;
      case 'red':
        if (event.second_yellow == true) {
          eventIcon = SizedBox.shrink();
        } else {
          eventIcon = Image.asset(
            'assets/icons/redCard.png', // Path to your custom icon
            width: 38,
            height: 43,
          );
        }
        break;
      case 'playerChange':
        eventIcon = Image.asset(
          'assets/icons/in_out.png', // Path to your custom icon
          width: 40,
          height: 40,
        );
        break;
      case 'penalty':
        eventIcon = event.status == 'goal'
            ? Image.asset(
                'assets/icons/penalty_in.png', // Icon for scored penalty
                width: 30,
                height: 30,
              )
            : Image.asset(
                'assets/icons/penalty_missed.png', // Icon for missed penalty
                width: 30,
                height: 30,
              );

        break;
      default:
        eventIcon = SizedBox.shrink();
    }
    if(event.is_own_goal == true){
      isHomeEvent = !isHomeEvent;
    }
    // Build the event row with player names and assist
    return Column(
      crossAxisAlignment:
          isHomeEvent ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment:
              isHomeEvent ? MainAxisAlignment.start : MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isHomeEvent) ...[
              if (event.second_yellow == true && event.type == 'red')
                ...[]
              else if (event.second_yellow == true &&
                  event.type == 'yellow') ...[
                eventIcon, // Event icon on the left for home tea
                SizedBox(width: 10),
                Text(timeString,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black)), // Time next to icon
                SizedBox(width: 5),
                Text(event.player!.first_name ?? "Unknown",
                    style: TextStyle(fontSize: 14, color: Colors.black)),
              ] else ...[
                eventIcon, // Event icon on the left for home tea
                SizedBox(width: 10),
                Text(timeString,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black)), // Time next to icon
                SizedBox(width: 5),
              ],
              if (event.type == 'playerChange') ...[
                Image.asset(
                  'assets/icons/arrowDown.png',
                  width: 30,
                  height: 30,
                ),
                Text(event.playerOut!.first_name!,
                    style: TextStyle(fontSize: 14, color: Colors.black)),
                Image.asset(
                  'assets/icons/arrowUP.png',
                  width: 30,
                  height: 30,
                ),
                Text(event.playerIn!.first_name!,
                    style: TextStyle(fontSize: 14, color: Colors.black)),
              ] else if (event.second_yellow == true)
                ...[]
              else ...[
                Text(
                  _getPlayerName(event), // Display the player name(s)
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
              if (event.assistPlayer != null &&
                  event.type == 'goal') // Ensure assist is shown for goals
                Padding(
                  padding: EdgeInsets.only(
                      left: isHomeEvent ? 5.0 : 0,
                      right: isAwayEvent ? 0.0 : 0),
                  child: Text(
                    '(${event.assistPlayer!.first_name})', // Show assist player if exists
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              if (event.is_own_goal == true &&
                  event.type == 'goal') // Ensure assist is shown for goals
                Padding(
                  padding: EdgeInsets.only(
                      left: isHomeEvent ? 5.0 : 0,
                      right: isAwayEvent ? 0.0 : 0),
                  child: Text("(own goal)",  // Show assist player if exists
                    style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02, color: Colors.grey),
                  ),
                ),
            ] else ...[
              if (event.is_own_goal == true &&
                  event.type == 'goal') // Ensure assist is shown for goals
                Padding(
                  padding: EdgeInsets.only(
                      left: isHomeEvent ? 5.0 : 0,
                      right: isAwayEvent ? 0.0 : 0),
                  child: Text("(own goal)",  // Show assist player if exists
                    style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02, color: Colors.grey),
                  ),
                ),
              if (event.assistPlayer != null &&
                  event.type == 'goal') // Ensure assist is shown for goals
                Padding(
                  padding: EdgeInsets.only(
                      left: isHomeEvent ? 5.0 : 0,
                      right: isAwayEvent ? 5.0 : 0),
                  child: Text(
                    '(${event.assistPlayer!.first_name})', // Show assist player if exists
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              if (event.type == 'playerChange') ...[
                Image.asset(
                  'assets/icons/arrowDown.png',
                  width: 30,
                  height: 30,
                ),
                Text(event.playerOut!.first_name!,
                    style: TextStyle(fontSize: 14, color: Colors.black)),
                Image.asset(
                  'assets/icons/arrowUP.png',
                  width: 30,
                  height: 30,
                ),
                Text(event.playerIn!.first_name!,
                    style: TextStyle(fontSize: 14, color: Colors.black)),
                Text(timeString,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black)), // Time next to player name
                SizedBox(width: 15),
                eventIcon,
              ] else if (event.second_yellow == true && event.type == 'red')
                ...[]
              else ...[
                Text(
                  _getPlayerName(event), // Display the player name(s)
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                SizedBox(width: 10),
                Text(timeString,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black)), // Time next to player name
                SizedBox(width: 15),
                eventIcon, // Event icon on the right for away team
              ],
            ],
          ],
        ),
      ],
    );
  }

  String _getPlayerName(Event event) {
    switch (event.type) {
      case 'goal':
        return event.player?.first_name ?? 'Unknown';
      case 'yellow':
        return event.player?.first_name ?? 'Unknown';
      case 'red':
        return event.player?.first_name ?? 'Unknown';
      case 'penalty':
        return event.player?.first_name ?? 'Unknown';
      case 'playerChange':
        return ('Out: ${event.playerOut?.first_name ?? 'Unknown'}, In: ${event.playerIn?.first_name ?? 'Unknown'}');
      default:
        return 'Unknown';
    }
  }
}

// Define an Event class to hold event information
class Event {
  final int? id;
  final String? min;
  final String type; // goal, card, playerChange
  final Player? player; // For goals and cards
  final Player? playerOut; // For player changes
  final Player? playerIn; // For player changes
  final Player? assistPlayer; // For goals with assists
  final int? team; // Assuming you have a way to identify team
  final bool penalty;
  final String? status;
  final bool? second_yellow;
  final bool? is_own_goal;

  Event({
    this.id,
    this.min,
    required this.type,
    this.player,
    this.playerOut,
    this.playerIn,
    this.assistPlayer,
    this.team,
    this.penalty = false,
    this.status,
    this.second_yellow,
    this.is_own_goal,
  });
}
