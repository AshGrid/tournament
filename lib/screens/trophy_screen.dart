import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Service/data_service.dart'; // Data service for fetching leagues, seasons, coupes, etc.
import '../components/image_slider.dart'; // Reusable image slider widget
import '../components/colors.dart'; // Custom colors for your app
import '../models/League.dart'; // League model
import '../models/Coupe.dart'; // Coupe model
import '../models/Coupe8.dart'; // Coupe8 model
import '../models/Season.dart'; // Season model
import '../models/Trophy.dart'; // Trophy model

class TrophyScreen extends StatefulWidget {
  final Trophy trophyName;
  final void Function(League league) onLeagueSelected;
  final void Function(Coupe coupe) onCoupeSelected;
  final void Function(Coupe8 coupe8) onCoupe8Selected;
  final bool isSeasonsLoading;
  final List<Season>? seasonsList;
  Season? selectedSeason;

  TrophyScreen({
    super.key,
    required this.trophyName,
    required this.onLeagueSelected,
    required this.onCoupeSelected,
    required this.onCoupe8Selected,
    required this.isSeasonsLoading,
    this.seasonsList,
    required this.selectedSeason,
  });

  @override
  _TrophyScreenState createState() => _TrophyScreenState();
}

class _TrophyScreenState extends State<TrophyScreen> {
  final DataService dataService = DataService();

  List<League> leaguesList = [];
  List<Coupe> coupesList = [];
  List<Coupe8> coupes8List = [];
  List<String> imagePaths = [];

  bool isAdsLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLeagues();
    _fetchCoupes();
    _fetchCoupes8();
    _fetchAds();
  }

  Future<void> _fetchAds() async {
    try {
      final fetchedAds = await dataService.fetchAds();
      setState(() {
        imagePaths = fetchedAds
            .where((ad) => ad.place == "trophy" && ad.image != null)
            .map((ad) => ad.image!)
            .toList();
        isAdsLoading = false;
      });
    } catch (e) {
      print("Error fetching ads: $e");
      setState(() {
        isAdsLoading = false;
      });
    }
  }
/// function for fetching leagues
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
    });
  }

  Future<void> _fetchCoupes8() async {
    final fetchedCoupes8 = await dataService.fetchCoupes8();
    setState(() {
      coupes8List = fetchedCoupes8;
    });
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "TBD";
    final DateFormat formatter = DateFormat('yyyy');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    List<League> filteredLeagues = leaguesList
        .where((league) =>
            league.trophy?.name == widget.trophyName.name &&
            league.id == widget.selectedSeason?.league?.id)
        .toList();

    List<Coupe> filteredCoupes = coupesList
        .where((coupe) =>
            coupe.season?.league?.trophy?.name?.toUpperCase() ==
                widget.trophyName.name?.toUpperCase() &&
            coupe.season?.id == widget.selectedSeason?.id)
        .toList();

    List<Coupe8> filteredCoupes8 = coupes8List
        .where((coupe8) =>
            coupe8.season?.league?.trophy?.name?.toUpperCase() ==
                widget.trophyName.name?.toUpperCase() &&
            coupe8.season?.id == widget.selectedSeason?.id)
        .toList();

    List<TrophyItem> combinedItems = [];
    combinedItems
        .addAll(filteredLeagues.map((league) => TrophyItem(league: league, trophyName: widget.trophyName)));
    combinedItems
        .addAll(filteredCoupes.map((coupe) => TrophyItem(coupe: coupe, trophyName: widget.trophyName)));
    combinedItems
        .addAll(filteredCoupes8.map((coupe8) => TrophyItem(coupe8: coupe8, trophyName: widget.trophyName)));

    double height =
        widget.trophyName.name?.toUpperCase() == "TROPHÉES DE CARTHAGE"
            ? 430
            : 350;

    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: widget.isSeasonsLoading
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    height: height,
                    margin: const EdgeInsets.all(12),
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
                        // Trophy header
                        Container(
                          height: 130,
                          decoration: BoxDecoration(
                            color: AppColors.trophyTitleComponent,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                margin:
                                    const EdgeInsets.only(left: 12, right: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(
                                      color: Colors.black12, width: 1),
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
                                      'assets/images/${widget.trophyName.name!.toUpperCase()}.png',
                                      fit: BoxFit.contain,
                                      width: 80,
                                      height: 80,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.trophyName.name!.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Depuis: ${_formatDate(widget.trophyName.date)}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        width: 130,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(9.0),
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                        ),
                                        child: DropdownButton<Season>(
                                          value: widget.selectedSeason,
                                          isExpanded: true,
                                          hint: const Text(
                                            "Select a Season",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          onChanged: (Season? newValue) {
                                            setState(() {
                                              widget.selectedSeason = newValue;
                                            });
                                          },
                                          underline: SizedBox(),
                                          items: widget.seasonsList
                                              ?.map<DropdownMenuItem<Season>>(
                                                  (Season season) {
                                                    return DropdownMenuItem<Season>(

                                                      value: season,
                                                      child: RichText(
                                                        text: TextSpan(
                                                          text: season.season ?? "Unknown Season", // Default season text
                                                          style: const TextStyle(fontSize: 15, color: Colors.black), // Base style
                                                          children: [
                                                            if (season.full_name!.contains("Samedi")) // Add "S" if "Samedi" is present
                                                              TextSpan(
                                                                text: "   S",
                                                                style: const TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 14, // Bigger font size for "S"
                                                                  color: AppColors.colorSaturday, // Optional: Change color if needed
                                                                ),
                                                              ),
                                                            if (season.full_name!.contains("Dimanche")) // Add "D" if "Dimanche" is present
                                                              TextSpan(
                                                                text: "   D",
                                                                style: const TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 14, // Bigger font size for "D"
                                                                  color: AppColors.colorSunday, // Optional: Change color if needed
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    );

                                                  }).toList(),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Trophy items
                        Expanded(
                          child: ListView.builder(
                            itemCount: combinedItems.length,
                            itemBuilder: (context, index) {
                              final item = combinedItems[index];
                              final backgroundColor = index.isEven
                                  ? AppColors.trophyItem1
                                  : Colors.transparent;
                              return Container(
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                      leading: Container(
                                        width: 55,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          border: Border.all(
                                            color: AppColors.bottomSheetLogo,
                                            width: 1.0,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.25),
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
                                    Divider(
                                        color:
                                            AppColors.trophyListTileItemBorder),
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
          SliverToBoxAdapter(
            child: isAdsLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ImageSlider(imagePaths: imagePaths),
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
  final Trophy trophyName; // Add this line

  TrophyItem({this.league, this.coupe, this.coupe8, required this.trophyName}); // Modify this line

  String imagePath() {
    if (league != null) {
      return "assets/images/${league!.name!.toUpperCase()}.png";
    } else if (coupe != null) {
      return "assets/images/${coupe!.name!.toUpperCase()}.png";
    } else if (coupe8 != null) {
      return "assets/images/${coupe8!.name!.toUpperCase()}.png";
    } else {
      return "assets/images/default.png";
    }
  }

  String displayName() {
    if (trophyName.name!.toUpperCase() == "RAMADAN CUP") {
      return "RAMADAN CUP";
    } else if (league != null) {
      return league!.name!.toUpperCase();
    } else if (coupe != null) {
      return coupe!.name!.toUpperCase();
    } else if (coupe8 != null) {
      return coupe8!.name!.toUpperCase();
    } else {
      return "Unknown";
    }
  }

  void onTap(BuildContext context, TrophyScreen widget) {
    if (league != null) {
      widget.onLeagueSelected(league!);
    } else if (coupe != null) {
      widget.onCoupeSelected(coupe!);
    } else if (coupe8 != null) {
      widget.onCoupe8Selected(coupe8!);
    }
  }
}
