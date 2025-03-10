import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:untitled/models/Coupe.dart';
import 'package:untitled/models/Coupe8.dart';
import 'package:untitled/models/InvitedPlayers.dart';
import 'package:untitled/models/League.dart';
import 'package:untitled/models/SuperPlayOff.dart';
import 'package:untitled/models/TeamRanking.dart';
import 'package:untitled/models/Trophy.dart';
import '../models/Bracket.dart';
import '../models/Card.dart';
import '../models/Club.dart';
import '../models/Goal.dart';
import '../models/Moment.dart';
import '../models/News.dart';
import '../models/Match.dart';
import '../models/Penalty.dart';
import '../models/Player.dart';
import '../models/PlayerChange.dart';
import '../models/PoolData.dart';
import '../models/Season.dart';
import '../models/Story.dart';
import '../models/Stream.dart';
import 'package:path_provider/path_provider.dart';

import '../models/SuperPlayOff8.dart';
import '../models/adBanner.dart';
import '../models/ramadan_cup.dart';

class DataService {
  final String baseUrl =
      'https://www.abcevents.com.tn/api/'; // Replace with your API URL

  /// Fetches news from the API

  Future<List<adBanner>> fetchAds() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl' + 'mobile_ads/'));

      // Check if the request was successful
      if (response.statusCode == 200) {
        final decodedBody = utf8.decode(response.bodyBytes);
        print("adBanner decoded body");
        print(
            decodedBody); // Debugging: Check if "é" is displayed correctly here
        // Decode the JSON response
        final List<dynamic> jsonData = json.decode(decodedBody);

        // Map the JSON data to a list of News objects
        return jsonData.map((item) => adBanner.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load adBanner: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching adBanner: $e');
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<News>> fetchNews() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl' + 'news'));

      // Check if the request was successful
      if (response.statusCode == 200) {
        final decodedBody = utf8.decode(response.bodyBytes);
        print("news decoded body");
        print(
            decodedBody); // Debugging: Check if "é" is displayed correctly here
        // Decode the JSON response
        final List<dynamic> jsonData = json.decode(decodedBody);

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

  Future<List<Season>> fetchSeasons() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl' + 'seasons'));

      // Check if the request was successful
      if (response.statusCode == 200) {
        final decodedBody = utf8.decode(response.bodyBytes);
        print("seasons decoded body");
        print(
            decodedBody); // Debugging: Check if "é" is displayed correctly here
        // Decode the JSON response
        final List<dynamic> jsonData = json.decode(decodedBody);

        // Map the JSON data to a list of News objects
        return jsonData.map((item) => Season.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load seasons: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching seasons: $e');
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<Penalty>> fetchPenalties(int matchId) async {
    final url = Uri.parse('$baseUrl' + 'penalties_by_match/$matchId/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((penalty) => Penalty.fromJson(penalty)).toList();
    } else {
      throw Exception('Failed to load penalties: ${response.body}');
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

  ///Pool Data

  Future<List<Bracket>> fetchBracketssData(int seasonId) async {
    final response = await http
        .get(Uri.parse(baseUrl + 'ramadan_cup_pools_by_season/$seasonId'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((bracket) => Bracket.fromJson(bracket)).toList();
    } else {
      throw Exception('Failed to load bracket data');
    }
  }

  Future<List<BracketData>> fetchBracketData(int seasonId) async {
    final response = await http.get(Uri.parse(baseUrl + 'ramadan_cup_brackets_by_season/$seasonId'));
    print("Brackets response code: ${response.statusCode}");
    print("Brackets response body: ${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      print("Decoded JSON Response: $jsonResponse"); // Debugging

      return jsonResponse.map((item) {
        print("Parsing item: $item"); // Debugging
        return BracketData.fromJson(item);
      }).toList();
    } else {
      throw Exception('Failed to load bracket data');
    }
  }

  Future<List<Bracket>> fetchBracketsData(int seasonId) async {
    final response = await http
        .get(Uri.parse(baseUrl + 'ramadan_cup_pools_by_season/$seasonId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((bracket) => Bracket.fromJson(bracket)).toList();
    } else {
      throw Exception('Failed to load bracket data');
    }
  }

  Future<List<PoolData>> fetchPoolData(int id) async {
    print("season id $id");
    try {
      // Make the HTTP GET request to the API endpoint
      final response = await http.get(Uri.parse(baseUrl +
          'ramadan_cup_pools_by_season/$id')); // Replace with your actual endpoint
      final utf8DecodedResponse = utf8.decode(response.bodyBytes);

      // Check if the request was successful
      if (response.statusCode == 200) {
        print(utf8DecodedResponse); // Print the response for debugging

        // Decode the JSON response
        final List<dynamic> jsonData = json.decode(utf8DecodedResponse);

        // Map the JSON data to a list of PoolData objects
        return jsonData.map((item) => PoolData.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load pool data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching pool data: $e');
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<StreamItem>> fetchStream() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + 'streaming'));
      final utf8DecodedResponse = utf8.decode(response.bodyBytes);

      // Check if the request was successful
      if (response.statusCode == 200) {
        print(
            utf8DecodedResponse); // Use response.body or utf8DecodedResponse to print the response
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
    final response = await http.get(Uri.parse(baseUrl + 'played_matches'));

    if (response.statusCode == 200) {
      print("played matches");
      print(response.body); // Ensure this shows a valid JSON array or object

      var list = jsonDecode(utf8.decode(response.bodyBytes));
      print("list played matches:$list");
      if (list is List) {
        // Assuming list is an array of JSON objects

        List<Match> matches = list.map((data) {
          return Match.fromJson(data);
        }).toList();

        return matches;
      } else {
        throw Exception('Expected a list but got something else');
      }
    } else {
      throw Exception('Failed to load matches');
    }
  }

  Future<List<DateTime>> fetchUpcomingMatchDates() async {
    final response =
        await http.get(Uri.parse(baseUrl + 'upcoming_match_dates'));

    if (response.statusCode == 200) {
      // Decode the JSON response
      var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print("upcoming_match_dates response: $jsonResponse");

      // Check if the 'upcoming_match_dates' field exists
      if (jsonResponse['upcoming_match_dates'] is List) {
        // Map the string dates to DateTime objects
        List<DateTime> dates =
            (jsonResponse['upcoming_match_dates'] as List).map((dateString) {
          return DateTime.parse(dateString); // Parse string to DateTime
        }).toList();
        return dates;
      } else {
        throw Exception('Expected a list but got something else');
      }
    } else {
      throw Exception('Failed to load matches');
    }
  }

  Future<List<Match>> fetchMatchesByDate(DateTime date) async {
    // Format the date as a string (e.g., '2024-10-19')
    String formattedDate =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    final response =
        await http.get(Uri.parse('$baseUrl  matches_by_date/$formattedDate'));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print("matches response: $jsonResponse");

      // Assuming the response contains a 'matches' key with the match data
      if (jsonResponse['matches'] is List) {
        // Map the JSON response to a List of Match objects
        return (jsonResponse['matches'] as List).map((matchJson) {
          return Match.fromJson(
              matchJson); // Use the factory method to create Match instances
        }).toList();
      } else {
        throw Exception('Expected a list of matches but got something else');
      }
    } else {
      throw Exception('Failed to load matches for date: $formattedDate');
    }
  }

  // Fetch a single match by ID
  Future<Match> fetchMatch(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/matches/$id'));

    if (response.statusCode == 200) {
      return Match.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load match');
    }
  }

  Future<List<Match>> fetchUpcomingMatches() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + 'upcoming_matches'));
      print(
          " upcaoming matches try catch block server code: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("upcoming matches");
        print(response.body);

        var list = jsonDecode(utf8.decode(response.bodyBytes));

        List<Match> matches =
            (list as List).map((data) => Match.fromJson(data)).toList();

        return matches;
      } else {
        throw Exception('Failed to load matches');
      }
    } catch (e) {
      print("Error loading upcaoming matches try catch block server: $e");
      // You can handle specific errors here as well
      return [];
    }
  }

  Future<List<Match>> fetchLiveMatches() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + 'live_matches/'));
      print(
          " live matches try catch block server code: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("live matches");
        print(response.body);

        var list = jsonDecode(utf8.decode(response.bodyBytes));

        List<Match> matches =
            (list as List).map((data) => Match.fromJson(data)).toList();

        return matches;
      } else {
        throw Exception('Failed to load live matches');
      }
    } catch (e) {
      print("Error loading live matches try catch block server: $e");
      // You can handle specific errors here as well
      return [];
    }
  }

  Future<Player> fetchPlayer(int player_id, int season_id) async {
    print("season: $season_id player: $player_id");
    final response = await http
        .get(Uri.parse(baseUrl + 'player_stats/$season_id/$player_id/'));
    if (response.statusCode == 200) {
      return Player.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load match');
    }
  }

  Future<Club> fetchClub(int club_id) async {
    final response = await http.get(Uri.parse(baseUrl + 'club/$club_id/'));
    if (response.statusCode == 200) {
      return Club.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load match');
    }
  }

  Future<List<Player>> fetchPlayers(int clubID) async {
    final response = await http.get(Uri.parse(baseUrl + 'players/$clubID'));

    if (response.statusCode == 200) {
      print("players");
      print(response.body);
      var list = jsonDecode(utf8.decode(response.bodyBytes));
      List<Player> players =
          (list as List).map((data) => Player.fromJson(data)).toList();
      return players;
    } else {
      throw Exception('Failed to load players by club id');
    }
  }

  Future<List<Match>> fetchMatchesByPlayer(int playerID) async {
    final response = await http.get(Uri.parse(baseUrl + 'players/$playerID'));

    if (response.statusCode == 200) {
      print("players");
      print(response.body);
      var list = jsonDecode(utf8.decode(response.bodyBytes));
      List<Match> matches =
          (list as List).map((data) => Match.fromJson(data)).toList();
      return matches;
    } else {
      throw Exception('Failed to load matches');
    }
  }

  Future<List<Story>> fetchStories() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + 'stories'));
      print(response.body);
      if (response.statusCode == 200) {
        print("status stories ok");
        // Parse the response body and convert it to a list of Story objects
        final List<dynamic> jsonData =
            json.decode(utf8.decode(response.bodyBytes));
        return jsonData.map((json) => Story.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load stories. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load stories: $error');
    }
  }

  Future<List<Moment>> fetchReels() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + 'moments'));
      print(response.body);
      if (response.statusCode == 200) {
        print("status moments ok");
        // Parse the response body and convert it to a list of Story objects
        final List<dynamic> jsonData =
            json.decode(utf8.decode(response.bodyBytes));
        return jsonData.map((json) => Moment.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load moments. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load moments: $error');
    }
  }

  Future<List<InvitedPlayers>> fetchInvitedPlayers(int matchId) async {
    try {
      print("$baseUrl invited_players_by_match/$matchId");

      final response = await http
          .get(Uri.parse(baseUrl + 'invited_players_by_match/$matchId'));

      if (response.statusCode == 200) {
        print("success invited players");
        // Parse the response body as a list of players
        List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));

        // Map each player JSON to an InvitedPlayer object
        return jsonData.map((json) => InvitedPlayers.fromJson(json)).toList();
      } else {
        print('Error: Failed with status code ${response.statusCode}');
        throw Exception('Failed to load Invited Players');
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw Exception('Error fetching invited players');
    }
  }

  Future<List<Club>> fetchClubs() async {
    final response = await http.get(Uri.parse(baseUrl + 'clubs'));

    if (response.statusCode == 200) {
      print("Clubs");
      print(response.body);
      var list = jsonDecode(utf8.decode(response.bodyBytes));
      List<Club> clubs =
          (list as List).map((data) => Club.fromJson(data)).toList();
      return clubs;
    } else {
      throw Exception('Failed to load clubs');
    }
  }

  Future<List<Club>> fetchTeamRankingPremirePhase() async {
    final response = await http.get(Uri.parse(baseUrl + 'clubs'));

    if (response.statusCode == 200) {
      print("Clubs");
      print(response.body);
      var list = jsonDecode(utf8.decode(response.bodyBytes));
      List<Club> clubs =
          (list as List).map((data) => Club.fromJson(data)).toList();
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

  Future<List<Coupe>> fetchCoupes() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + 'coupe/'));
      final utf8DecodedResponse = utf8.decode(response.bodyBytes);

      // Check if the request was successful
      if (response.statusCode == 200) {
        print("coupesList");

        // Decode the JSON response
        final List<dynamic> jsonData = json.decode(utf8DecodedResponse);
        print(jsonData.map((item) => Coupe.fromJson(item)).toList());
        // Map the JSON data to a list of News objects
        return jsonData.map((item) => Coupe.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load coupes: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching coupes: $e');
      return []; // Return an empty list in case of an error
    }
  }

  Future<SuperPlayOff?> fetchSuperPlayoff(int id) async {
    try {
      print("SuperPlayOff fetcheing league: $id ");
      final response =
          await http.get(Uri.parse(baseUrl + 'super_play_off/$id'));
      final utf8DecodedResponse = utf8.decode(response.bodyBytes);

      // Check if the request was successful
      if (response.statusCode == 200) {
        print("SuperPlayOff fetched successfully");

        // Decode the JSON response
        final Map<String, dynamic> jsonData = json.decode(utf8DecodedResponse);

        // Map the JSON data to a SuperPlayOff object
        return SuperPlayOff.fromJson(jsonData);
      } else {
        throw Exception('Failed to load SuperPlayOff: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching SuperPlayOff: $e');
      return null; // Return null in case of an error
    }
  }

  Future<SuperPlayOff8> fetchSuperPlayoff8ByLeagueId(int id) async {
    try {
      print("Fetching SuperPlayOff8 with league ID $id...");
      print('$baseUrl' + 'super_play_offs8/league/$id');
      final response =
          await http.get(Uri.parse('$baseUrl' + 'super_play_offs8/league/$id'));
      final utf8DecodedResponse = utf8.decode(response.bodyBytes);
      print("super playoff8 response code:${response.statusCode}");
      if (response.statusCode == 200) {
        print("SuperPlayOff8 list fetched successfully.");

        final List<dynamic> jsonData = json.decode(utf8DecodedResponse);

        final List<SuperPlayOff8> superPlayoffs8 = jsonData
            .map((item) => SuperPlayOff8.fromJson(item as Map<String, dynamic>))
            .toList();

        return superPlayoffs8.firstWhere(
          (playoff) => playoff.season?.league?.id == id,
          orElse: () {
            throw Exception("No SuperPlayOff8 found with league ID $id.");
          },
        );
      } else {
        throw Exception(
            'Failed to load SuperPlayOff8 list: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching SuperPlayOff8 from league: $e');
      rethrow; // Let the caller handle the exception
    }
  }

  Future<SuperPlayOff8?> fetchSuperPlayoff8(int id) async {
    try {
      print("SuperPlayOff 8 fetcheing ");
      final response =
          await http.get(Uri.parse(baseUrl + 'super_play_offs8/season/$id'));
      final utf8DecodedResponse = utf8.decode(response.bodyBytes);

      // Check if the request was successful
      if (response.statusCode == 200) {
        print("SuperPlayOff8 fetched successfully");

        // Decode the JSON response
        final Map<String, dynamic> jsonData = json.decode(utf8DecodedResponse);

        // Map the JSON data to a SuperPlayOff object
        return SuperPlayOff8.fromJson(jsonData);
      } else {
        throw Exception('Failed to load SuperPlayOff8: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching SuperPlayOff8: $e');
      return null; // Return null in case of an error
    }
  }

  Future<List<Coupe8>> fetchCoupes8() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + 'coupe8/'));
      final utf8DecodedResponse = utf8.decode(response.bodyBytes);

      // Check if the request was successful
      if (response.statusCode == 200) {
        print("cCoupe8List");

        // Decode the JSON response
        final List<dynamic> jsonData = json.decode(utf8DecodedResponse);
        print(jsonData.map((item) => Coupe8.fromJson(item)).toList());
        // Map the JSON data to a list of News objects
        return jsonData.map((item) => Coupe8.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load Coupe8: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching Coupe8: $e');
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<Coupe8>> league_super_trophies8() async {
    try {
      final response =
          await http.get(Uri.parse(baseUrl + 'league_super_trophies/'));
      final utf8DecodedResponse = utf8.decode(response.bodyBytes);

      // Check if the request was successful
      if (response.statusCode == 200) {
        print("league_super_trophies list");

        // Decode the JSON response
        final List<dynamic> jsonData = json.decode(utf8DecodedResponse);
        print(jsonData.map((item) => Coupe8.fromJson(item)).toList());
        // Map the JSON data to a list of News objects
        return jsonData.map((item) => Coupe8.fromJson(item)).toList();
      } else {
        throw Exception(
            'Failed to load league_super_trophies: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching league_super_trophies: $e');
      return []; // Return an empty list in case of an error
    }
  }

  Future<SuperPlayOff8?> league_super_trophies(int id) async {
    try {
      print("SuperPlayOff fetcheing ");
      final response =
          await http.get(Uri.parse(baseUrl + 'league_super_trophies8/'));
      final utf8DecodedResponse = utf8.decode(response.bodyBytes);

      // Check if the request was successful
      if (response.statusCode == 200) {
        print("SuperPlayOff8 fetched successfully");

        // Decode the JSON response
        final Map<String, dynamic> jsonData = json.decode(utf8DecodedResponse);

        // Map the JSON data to a SuperPlayOff object
        return SuperPlayOff8.fromJson(jsonData);
      } else {
        throw Exception('Failed to load SuperPlayOff8: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching SuperPlayOff8: $e');
      return null; // Return null in case of an error
    }
  }

  Future<List<Club>> fetchRankingByLeague2(int leagueId) async {
    try {
      print("fetchingRankingByLeague");
      final response =
          await http.get(Uri.parse(baseUrl + 'team_rankings/league/$leagueId'));
      final utf8DecodedResponse = utf8.decode(response.bodyBytes);

      // Check if the request was successful
      if (response.statusCode == 200) {
        print("fetchRankingByLeague");

        // Decode the JSON response
        final List<dynamic> jsonData = json.decode(utf8DecodedResponse);
        print(jsonData.map((item) => Club.fromJson(item)).toList());
        // Map the JSON data to a list of News objects
        return jsonData.map((item) => Club.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load Clubs: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching Clubs: $e');
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<Player>> fetchPlayersByClub(int clubId) async {
    try {
      print("fetchingRankingByLeague");
      final response = await http.get(Uri.parse(baseUrl + 'players/$clubId'));
      final utf8DecodedResponse = utf8.decode(response.bodyBytes);

      // Check if the request was successful
      if (response.statusCode == 200) {
        print("fetchPlayers by club");

        // Decode the JSON response
        final List<dynamic> jsonData =
            json.decode(utf8.decode(response.bodyBytes));
        print(jsonData.map((item) => Player.fromJson(item)).toList());
        // Map the JSON data to a list of News objects
        return jsonData.map((item) => Player.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load Players: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching Players: $e');
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<TeamRanking>> fetchRankingByLeague(int leagueId) async {
    try {
      print("fetchingRankingByLeague");
      final response =
          await http.get(Uri.parse(baseUrl + 'team_rankings/league/$leagueId'));
      final utf8DecodedResponse = utf8.decode(response.bodyBytes);

      // Check if the request was successful
      if (response.statusCode == 200) {
        print("fetchRankingByLeague");

        // Decode the JSON response
        final List<dynamic> jsonData = json.decode(utf8DecodedResponse);
        print(jsonData.map((item) => TeamRanking.fromJson(item)).toList());
        // Map the JSON data to a list of News objects
        return jsonData.map((item) => TeamRanking.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load Clubs: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching Clubs: $e');
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<Club>> fetchRankingBySeason(int seasonId) async {
    try {
      final response =
          await http.get(Uri.parse(baseUrl + 'team_rankings/league/$seasonId'));
      final utf8DecodedResponse = utf8.decode(response.bodyBytes);

      // Check if the request was successful
      if (response.statusCode == 200) {
        print("fetchRankingByLeague");

        // Decode the JSON response
        final List<dynamic> jsonData = json.decode(utf8DecodedResponse);
        print(jsonData.map((item) => Club.fromJson(item)).toList());
        // Map the JSON data to a list of News objects
        return jsonData.map((item) => Club.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load Clubs: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching Clubs: $e');
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<Club>> fetchRankingByPremierePhase(int phaseId) async {
    try {
      final response = await http
          .get(Uri.parse(baseUrl + 'team_rankings/premiere_phase/$phaseId'));
      final utf8DecodedResponse = utf8.decode(response.bodyBytes);

      // Check if the request was successful
      if (response.statusCode == 200) {
        print("fetchRankingByPhase");

        // Decode the JSON response
        final List<dynamic> jsonData = json.decode(utf8DecodedResponse);
        print(jsonData.map((item) => Club.fromJson(item)).toList());
        // Map the JSON data to a list of News objects
        return jsonData.map((item) => Club.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load Clubs: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching Clubs: $e');
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<Club>> fetchRankingByClub(int clubId) async {
    try {
      final response =
          await http.get(Uri.parse(baseUrl + 'team_rankings/club/$clubId'));
      final utf8DecodedResponse = utf8.decode(response.bodyBytes);

      // Check if the request was successful
      if (response.statusCode == 200) {
        print("fetchRankingByClub");

        // Decode the JSON response
        final List<dynamic> jsonData = json.decode(utf8DecodedResponse);
        print(jsonData.map((item) => Club.fromJson(item)).toList());
        // Map the JSON data to a list of News objects
        return jsonData.map((item) => Club.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load Clubs: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching Clubs: $e');
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<Card>> fetchCards(int matchId) async {
    final response =
        await http.get(Uri.parse('$baseUrl' 'cards/?match_id=$matchId'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((json) => Card.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cards');
    }
  }

  // Fetch player changes
  Future<List<PlayerChange>> fetchPlayerChanges(int matchId) async {
    print("$baseUrl player_changes/$matchId");
    final response = await http
        .get(Uri.parse('$baseUrl' 'player_changes/?match_id=$matchId'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((json) => PlayerChange.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load player changes');
    }
  }

  // Fetch goals
  Future<List<Goal>> fetchGoals(int matchId) async {
    final response =
        await http.get(Uri.parse('$baseUrl' 'goals/?match_id=$matchId'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((json) => Goal.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load goals');
    }
  }

// Placeholder for future methods to fetch other data
// Future<List<Match>> fetchMatches() async {...}
// Future<List<Team>> fetchTeams() async {...}
}
