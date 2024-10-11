import '../models/Club.dart';
import '../models/Arbitre.dart';
import '../models/InvitedPlayers.dart';
import '../models/Journey.dart';
import '../models/League.dart';
import '../models/MatchEvent.dart';
import '../models/Player.dart';
import '../models/Pool.dart';
import '../models/PremierePhase.dart';
import '../models/Season.dart';
import '../models/Supervisor.dart';
import '../models/Trophy.dart';
import '../models/User.dart';
import '../models/Venue.dart';
import '../models/Match.dart'; // Import the Match model

class MockData {
  static List<League> mockLeagues = [
    League(id: 1, name: 'Ligue Samedi', trophy: mockTrophies[0]),  // No trophy linked for now
    League(id: 2, name: 'Ligue Dimanche', trophy: mockTrophies[0]),
    League(id: 3, name: 'Coupe Samedi', trophy: mockTrophies[0]),
    League(id: 5, name: 'Coupe Dimanche', trophy: mockTrophies[0]),
    League(id: 6, name: 'ligue VÉTÉRANS', trophy: mockTrophies[3]),
    League(id: 7, name: 'Coupe VÉTÉRANS', trophy: mockTrophies[3]),
    League(id: 8, name: 'Coupe it', trophy: mockTrophies[1]),
    League(id: 9, name: 'Ligue it', trophy: mockTrophies[1]),
  ];
  static final List<League> mockLeaguesVeterans = [
    League(
      id: 1,
      name: 'Ligue Vétérans',
      // Initialize with empty list, will fill later
    ),
    League(
      id: 2,
      name: 'Coupe Vétérans',
       // Initialize with empty list, will fill later
    ),

  ];
  static final List<League> mockLeaguesIT = [
    League(
      id: 1,
      name: 'Ligue IT',
      // Initialize with empty list, will fill later
    ),
    League(
      id: 2,
      name: 'Coupe IT',
       // Initialize with empty list, will fill later
    ),

  ];
  static final List<League> mockLeaguesCorporate = [

  ];

  static final List<Trophy> mockTrophies = [
    Trophy(
      id: 1,
      name: 'TROPHÉES DE CARTHAGE',
      image: 'https://example.com/champion_trophy.png',
      date: DateTime(2024, 5, 1),

    ),
    Trophy(
      id: 2,
      name: 'TROPHÉES IT',
      image: 'https://example.com/runner_up_trophy.png',
      date: DateTime(2024, 5, 15),

    ),
    Trophy(
      id: 3,
      name: 'TUNISIA CORPORATE CUP',
      image: 'https://example.com/best_player_trophy.png',
      date: DateTime(2024, 6, 1),

    ),
    Trophy(
      id: 4,
      name: 'TROPHÉES VÉTÉRANS',
      image: 'https://example.com/most_goals_trophy.png',
      date: DateTime(2024, 6, 15),

    ),
  ];

  static final List<Club> mockClubs = [
    Club(
      id: 1,
      name: 'Club A',
      abbreviation: 'CLA',
      logo: 'https://example.com/clubA_logo.png',
      cover: 'https://example.com/clubA_cover.png',
      maillot: 'Red',
      short: 'White',
      bas: 'White',
      league: 1, // Assuming league is an integer representing the league ID
      responsible_email: 'clubA@example.com',
      responsible_name: 'Manager A',
      order_main_page: 1,
      order: 1,
      active: true,
      send_mail: true,
    ),
    Club(
      id: 2,
      name: 'Club B',
      abbreviation: 'CLB',
      logo: 'https://example.com/clubB_logo.png',
      cover: 'https://example.com/clubB_cover.png',
      maillot: 'Blue',
      short: 'Black',
      bas: 'Black',
      league: 1, // Assuming league is an integer representing the league ID
      responsible_email: 'clubB@example.com',
      responsible_name: 'Manager B',
      order_main_page: 2,
      order: 2,
      active: true,
      send_mail: true,
    ),
  ];


  static final List<Venue> mockVenues = [
    Venue(id: 1, name: 'Stadium A', address: '123 Stadium Street'),
    Venue(id: 2, name: 'Stadium B', address: '456 Stadium Avenue'),
  ];

  static final List<Arbitre> mockArbitres = [
    Arbitre(id: 1, name: 'Referee A'),
    Arbitre(id: 2, name: 'Assistant Referee B'),
  ];

  static final List<Supervisor> mockSupervisors = [
    Supervisor(
      id: 1,
      user: User(
        id: 1,
        email: 'supervisorA@example.com',
        firstName: 'John',
        lastName: 'Doe',
        isActive: true,
        isStaff: true,
        isAdmin: false,
        gender: 'Male',
        birthday: DateTime(1985, 6, 15),
        phoneNumber: '123-456-7890',
        address: '456 Supervisor St.',
        role: 'Supervisor',
      ),
      name: 'Supervisor A',
    ),
  ];

  static final List<Season> mockSeasons = [
    Season(
      id: 1,
      season: '2023-2024',
      league: mockLeagues[0], // Use Premier League for this season
      teams: mockClubs,
    ),
  ];

  static final List<PremierePhase> mockPremierePhases = [
    PremierePhase(
      id: 1,
      season: mockSeasons[0],
      type: 'Regular',
      createPool: true,
      createMatch: true,
      automaticJourney: false,
    ),
  ];

  static final List<Journey> mockJourneys = [
    Journey(
      id: 1,
      pool: Pool(
        id: 1,
        premierePhase: mockPremierePhases[0],
        teams: mockClubs,
        createMatches: true,
        type: 'Group',
      ),
      number: 1,
    ),
  ];

  static final List<Match> mockMatches = [
    Match(
      id: 1,
      home: mockClubs[0], // Home team from mockClubs
      away: mockClubs[1], // Away team from mockClubs
      date: DateTime(2024, 10, 1),
      venue: mockVenues[0], // Venue from mockVenues
      arbitres: mockArbitres, // List of arbitres from mockArbitres
      supervisors: mockSupervisors, // List of supervisors from mockSupervisors
      home_first_half_score: 1, // Updated field names
      away_first_half_score: 0,
      home_second_half_score: 2,
      away_second_half_score: 1,
      status: 'completed',
      is_ended: true, // Updated field name
      trophy: mockTrophies[0], // Nullable Trophy
      season: mockSeasons[0], // Nullable Season
      premierePhase: mockPremierePhases[0], // Nullable PremierePhase
      is_premiere_phase: true,
      is_playoff: false,
      is_trophy: true,
      is_super_trophy: false,
      is_super_playoff: false,
      is_coupe: false,
      is_super_coupe: false,
      journey: mockJourneys[0], // Nullable Journey
    ),
    Match(
      id: 2,
      home: mockClubs[1],
      away: mockClubs[0],
      date: DateTime(2024, 10, 15),
      venue: mockVenues[1],
      arbitres: mockArbitres,
      supervisors: mockSupervisors,
      home_first_half_score: 0,
      away_first_half_score: 1,
      home_second_half_score: 1,
      away_second_half_score: 1,
      status: 'completed',
      is_ended: true,
      trophy: mockTrophies[0],
      season: mockSeasons[0],
      premierePhase: mockPremierePhases[0],
      is_premiere_phase: true,
      is_playoff: false,
      is_trophy: true,
      is_super_trophy: false,
      is_super_playoff: false,
      is_coupe: false,
      is_super_coupe: false,
      journey: mockJourneys[0],
    ),
  ];


  // Assign matches to each league


  static final List<Player> invitedPlayersList = [
    Player(
      id: 1,
      firstName: 'John',
      lastName: 'Doe',
      nationality: 'American',
      number: "1",
      avatar: 'path/to/avatar',
      cinImage: 'path/to/cinImage',
      cin: '123456',
      birthday: DateTime(2000, 1, 1),
      attestation: 'path/to/attestation',
      medicalCertificate: 'path/to/medicalCertificate',
      taille: "180",
      club: mockClubs[1],
      captain: false,
      verified: true,
      declineReason: '',
      pendingVerification: false,
      suspended: false,
      suspensionDuration: 0,
      position: 'Guardien',
    ),
    Player(
      id: 2,
      firstName: 'Alice',
      lastName: 'Smith',
      nationality: 'Canadian',
      number: "2",
      avatar: 'path/to/avatar2',
      cinImage: 'path/to/cinImage2',
      cin: '654321',
      birthday: DateTime(1995, 2, 2),
      attestation: 'path/to/attestation2',
      medicalCertificate: 'path/to/medicalCertificate2',
      taille: "175",
      club: mockClubs[0],
      captain: true,
      verified: true,
      declineReason: '',
      pendingVerification: false,
      suspended: false,
      suspensionDuration: 0,
      position: 'Attaquant',
    ),
  ];

  // Call this method to assign matches to leagues

}
