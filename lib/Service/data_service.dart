import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled/models/InvitedPlayers.dart';
import 'package:untitled/models/League.dart';
import 'package:untitled/models/Trophy.dart';
import '../models/Club.dart';
import '../models/News.dart';
import '../models/Match.dart';
import '../models/Player.dart';
import '../models/Stream.dart';

class DataService {
  final String baseUrl = 'https://dev.abcevents.com.tn/api/'; // Replace with your API URL

  /// Fetches news from the API
  Future<List<News>> fetchNews() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + 'news'));
      final utf8DecodedResponse = utf8.decode(response.bodyBytes);

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Decode the JSON response
        final List<dynamic> jsonData = json.decode(utf8DecodedResponse);

        // Map the JSON data to a list of News objects
        return jsonData.map((item) => News.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching news: $e');
      return []; // Return an empty list in case of an error
    }
  }





  Future<List<Trophy>> fetchTrophies() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + 'trophies'));
      final utf8DecodedResponse = utf8.decode(response.bodyBytes);

      // Check if the request was successful
      if (response.statusCode == 200) {
        print("trophiesList");

        // Decode the JSON response
        final List<dynamic> jsonData = json.decode(utf8DecodedResponse);
print(jsonData.map((item) => Trophy.fromJson(item)).toList());
        // Map the JSON data to a list of News objects
        return jsonData.map((item) => Trophy.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load trophies: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching trophies: $e');
      return []; // Return an empty list in case of an error
    }
  }


  Future<List<StreamItem>> fetchStream() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + 'streaming'));
      final utf8DecodedResponse = utf8.decode(response.bodyBytes);

      // Check if the request was successful
      if (response.statusCode == 200) {
        print(utf8DecodedResponse); // Use response.body or utf8DecodedResponse to print the response
        // Decode the JSON response
        final List<dynamic> jsonData = json.decode(utf8DecodedResponse);

        // Map the JSON data to a list of StreamItem objects
        return jsonData.map((item) => StreamItem.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load streams: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching streams: $e');
      return []; // Return an empty list in case of an error
    }
  }


  Future<List<Match>> fetchPlayedMatches() async {
    final response = await http.get(Uri.parse(baseUrl+'played_matches'));

    if (response.statusCode == 200) {
      print("matches");
      print(response.body);
      var list = jsonDecode(response.body);
      List<Match> matches = (list as List)
          .map((data) => Match.fromJson(data))
          .toList();
      return matches;
    } else {
      throw Exception('Failed to load matches');
    }
  }
  // Fetch a single match by ID
  Future<Match> fetchMatch(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/matches/$id'));

    if (response.statusCode == 200) {
      return Match.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load match');
    }
  }


  Future<List<Match>> fetchUpcomingMatches() async {
    final response = await http.get(Uri.parse(baseUrl+'upcoming_matches'));

    if (response.statusCode == 200) {
      print("matches");
      print(response.body);
      var list = jsonDecode(response.body);
      List<Match> matches = (list as List)
          .map((data) => Match.fromJson(data))
          .toList();
      return matches;
    } else {
      throw Exception('Failed to load matches');
    }
  }


  Future<List<Player>> fetchPlayers(String clubID) async {
    final response = await http.get(Uri.parse(baseUrl+'players/'+clubID));

    if (response.statusCode == 200) {
      print("players");
      print(response.body);
      var list = jsonDecode(response.body);
      List<Player> players = (list as List)
          .map((data) => Player.fromJson(data))
          .toList();
      return players;
    } else {
      throw Exception('Failed to load matches');
    }
  }




  Future<InvitedPlayers> fetchInvitedPlayers(int matchId) async {
    final response = await http.get(Uri.parse('$baseUrl/invited_players/$matchId'));

    if (response.statusCode == 200) {
      return InvitedPlayers.fromJson(json.decode(response.body));
    } else {
      print(response.statusCode);
      throw Exception('Failed to load InvitedPlayers');
    }
  }


  Future<List<Club>> fetchClubs() async {
    final response = await http.get(Uri.parse(baseUrl+'clubs'));

    if (response.statusCode == 200) {
      print("Clubs");
      print(response.body);
      var list = jsonDecode(response.body);
      List<Club> clubs = (list as List)
          .map((data) => Club.fromJson(data))
          .toList();
      return clubs;
    } else {
      throw Exception('Failed to load clubs');
    }
  }


  Future<List<League>> fetchLeagues() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + 'leagues'));
      final utf8DecodedResponse = utf8.decode(response.bodyBytes);

      // Check if the request was successful
      if (response.statusCode == 200) {
        print("LeaguesList");

        // Decode the JSON response
        final List<dynamic> jsonData = json.decode(utf8DecodedResponse);
        print(jsonData.map((item) => League.fromJson(item)).toList());
        // Map the JSON data to a list of News objects
        return jsonData.map((item) => League.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load Leagues: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching Leagues: $e');
      return []; // Return an empty list in case of an error
    }
  }

// Placeholder for future methods to fetch other data
// Future<List<Match>> fetchMatches() async {...}
// Future<List<Team>> fetchTeams() async {...}
}
