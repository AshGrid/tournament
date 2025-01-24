import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For shared preferences
import '../Service/data_service.dart';
import '../components/NotificatinItem.dart';
import '../models/Club.dart';
import '../models/Match.dart';

class NotificationScreen extends StatefulWidget {
  final List<String> savedClubs;

  NotificationScreen({
    Key? key,
    required this.savedClubs,
  }) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final DataService dataService = DataService();
  List<Match> matches = [];
  bool isMatchesLoading = true;
List<Club> clubs = [];


  DateTime? parseMatchDate(String dateString, String timeString) {
    // Example date and time format: 'MM/DD/YYYY' and 'HH:mm'
    final dateFormat = DateFormat('yyyy-MM-dd'); // Change this to match your date format
    final timeFormat = DateFormat('HH:mm');

    try {
      DateTime date = dateFormat.parse(dateString);
      DateTime time = timeFormat.parse(timeString);
      // Combine date and time
      return DateTime(date.year, date.month, date.day, time.hour, time.minute);
    } catch (e) {
      print('Error parsing date or time: $e');
      return null; // Handle the error as needed
    }
  }

  Future<void> _fetchMatches() async {
    try {
      // Fetch all upcoming matches from your data service
      final fetchedUpcomingMatches = await dataService.fetchUpcomingMatches();

      // Get the current time
      final now = DateTime.now();

      // Define the time thresholds
      final oneHourFromNow = now.add(Duration(hours: 1));
      final oneDayFromNow = now.add(Duration(days: 1));
      final DateTime today = DateTime(now.year, now.month, now.day);
      // Print all fetched matches' dates and times for debugging


      // Filter matches based on the conditions
      final filteredMatches = fetchedUpcomingMatches.where((match) {
        // Ensure home and away objects are not null before accessing their ids
        bool isInSavedClubs = widget.savedClubs.contains(match.home?.id.toString()) ||
            widget.savedClubs.contains(match.away?.id.toString());

        if (widget.savedClubs.contains(match.home?.id.toString())) {
          clubs.add(match.home!);
        }
        if (widget.savedClubs.contains(match.away?.id.toString())) {
          clubs.add(match.away!);
        }

        // Parse time string and combine with matchDate
        if (match.date != null && match.time != null) {
          final timeParts = match.time?.split(':');
          if (timeParts?.length == 3) {
            final hour = int.tryParse(timeParts![0]) ?? 0;
            final minute = int.tryParse(timeParts[1]) ?? 0;

            // Create a DateTime object for the match time
            final matchDateTime = DateTime(
              match.date!.year,
              match.date!.month,
              match.date!.day,
              hour,
              minute,
            );

            // Check if the match is today
            bool isToday = matchDateTime.year == today.year &&
                matchDateTime.month == today.month &&
                matchDateTime.day == today.day;

            // Check if the match is live or within the specified time frames
            return isInSavedClubs &&
                (matchDateTime.isAfter(now) && matchDateTime.isBefore(oneHourFromNow) ||
                    matchDateTime.isAfter(oneHourFromNow) && matchDateTime.isBefore(oneDayFromNow) ||
                    isToday ||
                    match.status == 'live');
          }
        }
        return false; // Return false if conditions aren't met
      }).toList();
      // Print filtered matches' details for debugging
      print('Filtered Matches:');
      for (var match in filteredMatches) {
        print('Match Date: ${match.date}, Time: ${match.time}, Status: ${match.status}');
      }

      // Update the state with the filtered matches
      if (mounted) {
        setState(() {
          matches = filteredMatches;
          isMatchesLoading = false;
        });
      }

    } catch (error) {
      // Handle errors and stop loading state
      if (mounted) {
        setState(() {
          isMatchesLoading = false;
        });
      }
      print('Error fetching matches: $error'); // Optional: Add logging for the error
    }
  }







  @override
  void initState() {
    super.initState();
    print('saved clubs notif screen: ${widget.savedClubs}');
    _fetchMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.transparent,
      body: isMatchesLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator while loading
          : widget.savedClubs.isEmpty
          ? Center(child: Text('No notifications for your clubs'))
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildNotificationList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Keeps list size according to content
      physics: NeverScrollableScrollPhysics(), // Prevents internal scrolling
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];

        // Determine which club (home or away) is listed in savedClubs
        String? clubName;
        String? clubLogo;
        if (widget.savedClubs.contains(match.home?.id.toString())) {
          clubName = match.home?.name; // Use home club's name
          clubLogo = match.home?.logo; // Use home club's logo
        } else if (widget.savedClubs.contains(match.away?.id.toString())) {
          clubName = match.away?.name; // Use away club's name
          clubLogo = match.away?.logo; // Use away club's logo
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: NotificationItem(match: match,clubName: clubName!,logo: clubLogo!), // Use the NotificationItem widget
        );
      },
    );
  }
}
