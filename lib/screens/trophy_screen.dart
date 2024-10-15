import 'package:flutter/material.dart';
import 'package:untitled/models/Coupe8.dart';
import '../Service/data_service.dart'; // Your data service
import '../components/image_slider.dart'; // Your image slider component
import '../components/colors.dart'; // Import your custom colors
import '../models/League.dart'; // League model
import '../models/Coupe.dart'; // Coupe model
import '../models/Trophy.dart';
import 'coupeDetailsScreen.dart';
import 'coupe_8_details.dart'; // Import your CoupeDetailsScreen

class TrophyScreen extends StatefulWidget {
  final String trophyName;

  final void Function(League league) onLeagueSelected;
  final void Function(Coupe coupe) onCoupeSelected;
  final void Function(Coupe8 coupe8) onCoupe8Selected;

  const TrophyScreen({
    super.key,

    required this.trophyName,
    required this.onLeagueSelected,
    required this.onCoupeSelected,
    required this.onCoupe8Selected,  });

  @override
  _TrophyScreenState createState() => _TrophyScreenState();
}

class _TrophyScreenState extends State<TrophyScreen> {
  final DataService dataService = DataService();

  List<League> leaguesList = [];
  List<Coupe> coupesList = []; // List for Coupes
  List<Coupe8> coupes8List = []; // List for Coupe8

  Future<void> _fetchLeagues() async {
    final fetchedLeagues = await dataService.fetchLeagues();
    setState(() {
      leaguesList = fetchedLeagues;
    });
  }

  Future<void> _fetchCoupes() async {
    final fetchedCoupes = await dataService.fetchCoupes();
    setState(() {
      coupesList = fetchedCoupes;

      for (var coupe in coupes8List) {
        print("Coupe name: ${coupe.season?.league?.trophy?.name}");
      }
    });
  }

  Future<void> _fetchCoupes8() async {
    final fetchedCoupes8 = await dataService.fetchCoupes8();
    setState(() {
      coupes8List = fetchedCoupes8;

      // Print the names of all the fetched coupes
      for (var coupe in coupes8List) {
        print("Coupe8 name: ${coupe.season?.league?.trophy?.name}");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchLeagues();
    _fetchCoupes();
    _fetchCoupes8(); // Fetch Coupes8
  }

  @override
  Widget build(BuildContext context) {
    // Filtering leagues based on the trophy name
    List<League> filteredLeagues = leaguesList
        .where((league) => league.trophy!.name == widget.trophyName)
        .toList();
          print("filteredLeagues: $filteredLeagues");
    // Filtering coupes based on the trophy name
    List<Coupe> filteredCoupes = coupesList
        .where((coupe) => coupe.season!.league?.trophy!.name!.toUpperCase() == widget.trophyName.toUpperCase())
        .toList();
print("coupe: $filteredCoupes");
    // Filtering coupes8 based on the trophy name
    List<Coupe8> filteredCoupes8 = coupes8List
        .where((coupe8) => coupe8.season!.league?.trophy!.name!.toUpperCase() == widget.trophyName.toUpperCase())
        .toList();
    print("coupe8: $filteredCoupes8");
    // Create a combined list of TrophyItems
    List<TrophyItem> combinedItems = [];
    combinedItems.addAll(filteredLeagues.map((league) => TrophyItem(league: league)));
    combinedItems.addAll(filteredCoupes.map((coupe) => TrophyItem(coupe: coupe)));
    combinedItems.addAll(filteredCoupes8.map((coupe8) => TrophyItem(coupe8: coupe8)));

    // Image paths for the slider
    List<String> imagePath = [
      'assets/images/image1.jpeg',
      'assets/images/image2.jpeg',
      'assets/images/image1.jpeg',
    ];

    double height = widget.trophyName.toUpperCase() == "TROPHÉES DE CARTHAGE" ? 430 : 350;

    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      body: CustomScrollView(
        slivers: [
          // Big Container with Trophy Name and Logo
          SliverToBoxAdapter(
            child: Container(
              height: height,
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: AppColors.trophyComponent,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Trophy Name and Logo
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: AppColors.trophyTitleComponent,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Trophy Image
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(left: 12, right: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(color: Colors.black12, width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 4,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/${widget.trophyName.toUpperCase()}.png',
                                fit: BoxFit.contain,
                                width: 80,
                                height: 80,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 2),
                        // Trophy Name
                        Expanded(
                          child: Text(
                            widget.trophyName.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // List of Leagues, Coupes, and Coupes8
                  SizedBox(
                    height: height - 130,
                    child: ListView.builder(
                      itemCount: combinedItems.length,
                      itemBuilder: (context, index) {
                        final item = combinedItems[index];
                        final backgroundColor =
                        index.isEven ? AppColors.trophyItem1 : Colors.transparent;

                        return Container(
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                leading: Container(
                                  width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                      color: AppColors.bottomSheetLogo,
                                      width: 1.0,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        blurRadius: 4.0,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Image.asset(
                                      item.imagePath(),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  item.displayName(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    fontFamily: "oswald",
                                  ),
                                ),
                                onTap: () {
                                  item.onTap(context, widget);
                                },
                              ),
                              Divider(color: AppColors.trophyListTileItemBorder),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: ImageSlider(
              imagePaths: imagePath,
            ),
          ),
        ],
      ),
    );
  }
}

class TrophyItem {
  final League? league;
  final Coupe? coupe;
  final Coupe8? coupe8;

  TrophyItem({this.league, this.coupe, this.coupe8});

  bool get isLeague => league != null;
  bool get isCoupe => coupe != null;
  bool get isCoupe8 => coupe8 != null;

  String imagePath() {
    if (isLeague) {
      return "assets/images/${league!.name!.toUpperCase()}.png";
    } else if (isCoupe) {
      return "assets/images/${coupe!.name!.toUpperCase()}.png";
    } else {
      return "assets/images/${coupe8!.name!.toUpperCase()}.png";
    }
  }

  String displayName() {
    if (isLeague) {
      return league!.name!.toUpperCase();
    } else if (isCoupe) {
      return coupe!.name!.toUpperCase();
    } else {
      return coupe8!.name!.toUpperCase();
    }
  }

  void onTap(BuildContext context, TrophyScreen widget) {
    if (isLeague) {
      widget.onLeagueSelected(league!);
    } else if (isCoupe) {
      widget.onCoupeSelected(coupe!);

    } else if (isCoupe8) {
      widget.onCoupe8Selected(coupe8!);
    }
  }
}
