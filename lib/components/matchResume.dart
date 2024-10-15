import 'package:flutter/material.dart';
import '../Service/data_service.dart';
import '../models/Card.dart'; // Import your Card model
import '../models/Club.dart';
import '../models/Goal.dart'; // Import your Goal model
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

  Future<void> _fetchGoalsList() async {
    final fetchedGoals = await dataService.fetchGoals(widget.match.id!);

    setState(() {
      _goals = fetchedGoals;
    });
  }

  Future<void> _fetchPlayerChangeList() async {
    final fetchedPlayerChanges = await dataService.fetchPlayerChanges(widget.match.id!);

    setState(() {
      _playerChanges = fetchedPlayerChanges;
    });
  }

  Future<void> _fetchMatchDetails() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate delay
    _fetchCardsList();
    _fetchGoalsList();
    _fetchPlayerChangeList();

    setState(() {
      _isLoading = false; // Set loading to false after data is fetched
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Event> events = _combineEvents();
    events.sort((a, b) => b.min!.compareTo(a.min!)); // Sort events by time

    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: _isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator while fetching data
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
      events.add(Event(
        min: goal.min,
        type: 'goal',
        player: goal.player,
        assistPlayer: goal.assist, // Assuming Goal has assistPlayer
        team: goal.player?.club, // Assuming Player model has a club attribute
      ));
      print("goal: ${goal.player?.club}");

    }

    // Add cards
    for (var card in _cards) {
      events.add(Event(
        min: card.min,
        type: card.type!.toLowerCase(),
        player: card.player,
        team: card.player?.club, // Assuming Player model has a club attribute
      ));
    }

    // Add player changes
    for (var change in _playerChanges) {
      events.add(Event(
        min: change.min,
        type: 'playerChange',
        playerOut: change.player_out,
        playerIn: change.player_in,
        team: change.player_out?.club, // Assuming Player model has a club attribute
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
        eventIcon = Image.asset(
          'assets/icons/ball.png', // Path to your custom icon
          width: 20,
          height: 20,
        );
        break;
      case 'yellow':
        eventIcon = Image.asset(
          'assets/icons/yellowCard.png', // Path to your custom icon
          width: 20,
          height: 20,
        );
        break;
      case 'red':
        eventIcon = Image.asset(
          'assets/icons/redCard.png', // Path to your custom icon
          width: 20,
          height: 20,
        );
        break;
      case 'playerChange':
        eventIcon = Image.asset(
          'assets/icons/in_out.png', // Path to your custom icon
          width: 20,
          height: 20,
        );
        break;
      default:
        eventIcon = SizedBox.shrink();
    }

    // Build the event row with player names and assist
    return Row(
      mainAxisAlignment: isHomeEvent ? MainAxisAlignment.start : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isHomeEvent) SizedBox(width: 0), // Add spacing for home events
        Expanded(
          child: Column(
            crossAxisAlignment: isHomeEvent ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  eventIcon, // Display the event icon here
                  SizedBox(width: 5),
                  Text(timeString, style: TextStyle(fontSize: 12)), // Time next to icon
                  SizedBox(width: 10),
                  Text(
                    _getPlayerName(event), // Display the player name(s)
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              if (event.assistPlayer != null && event.type == 'goal')
                Text(
                  'Assist: ${event.assistPlayer!.first_name}', // Show assist player if exists
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
            ],
          ),
        ),
        if (!isHomeEvent) SizedBox(width: 20), // Add spacing for away events
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
      case 'playerChange':
        return 'Out: ${event.playerOut?.first_name ?? 'Unknown'}, In: ${event.playerIn?.first_name ?? 'Unknown'}';
      default:
        return 'Unknown';
    }
  }
}

// Define an Event class to hold event information
class Event {
  final String? min;
  final String type; // goal, card, playerChange
  final Player? player; // For goals and cards
  final Player? playerOut; // For player changes
  final Player? playerIn; // For player changes
  final Player? assistPlayer; // For goals with assists
  final int? team; // Assuming you have a way to identify team

  Event({
    this.min,
    required this.type,
    this.player,
    this.playerOut,
    this.playerIn,
    this.assistPlayer,
    this.team,
  });
}
