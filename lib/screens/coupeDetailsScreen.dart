import 'package:flutter/material.dart';
import 'package:untitled/components/superPlayOffCalendar.dart';
import 'package:untitled/components/superPlayOffResultats.dart';
import 'package:untitled/components/tropheeHannibalCalendar.dart';
import 'package:untitled/components/tropheeHannibalResultats.dart';
import 'package:untitled/components/tropheeHannibalTableau.dart';
import 'package:untitled/models/Coupe8.dart';
import 'package:untitled/models/League.dart';
import '../Service/data_service.dart';
import '../components/CoupeCalendar.dart';
import '../components/CoupeResultas.dart';
import '../components/CoupeTableau.dart';
import '../components/colors.dart';
import '../components/superPlayOffTableau.dart';
import '../models/Club.dart';
import '../models/Coupe.dart';
import '../models/Trophy.dart';

class CoupeDetailsScreen extends StatefulWidget {
  final Coupe coupe;
  final Trophy trophyName;

  const CoupeDetailsScreen({super.key, required this.coupe, required this.trophyName});

  @override
  _CoupeDetailsScreenState createState() => _CoupeDetailsScreenState();
}

class _CoupeDetailsScreenState extends State<CoupeDetailsScreen> {
  int selectedIndex = 0;
  List<String> years = List.generate(15, (index) => (DateTime.now().year - index).toString());
  String selectedYear = DateTime.now().year.toString(); // Default selected year
  List<Club> clubsList = [];
  final DataService dataService = DataService();


  @override
  void initState() {
    super.initState();
    print("coupe name to test stuff@ ${widget.coupe.name}");

    print("trophy name to test stuff@ ${widget.trophyName}");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        decoration: BoxDecoration(
          gradient: AppColors.backgroundColor,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildHeader(),
            ),
            SliverToBoxAdapter(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
                child: _buildSelectedContent(widget.coupe),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.trophyComponent,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLeagueInfo(),
          const SizedBox(height: 5),
          _buildMenu(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildLeagueInfo() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.trophyTitleComponent,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.transparent.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // League Image in a rounded container
          _buildLeagueLogo(),
          const SizedBox(width: 10),
          // League Name
          Expanded(child: _buildLeagueDetails()),
        ],
      ),
    );
  }

  Widget _buildLeagueLogo() {
    return Container(
      width: 100,
      height: 100,
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
            'assets/images/${widget.trophyName.name!.toUpperCase()}.png',
            fit: BoxFit.contain,
            width: 80,
            height: 80,
          ),
        ),
      ),
    );
  }

  Widget _buildLeagueDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.trophyName.name!.toUpperCase(),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 4),
        Text(
          widget.coupe.name!,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 4),
        //_buildYearDropdown(),
      ],
    );
  }

  Widget _buildYearDropdown() {
    return Row(
      children: [

        const Spacer(),
        // DropdownButton for Year Selection
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          width: 50,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: DropdownButton<String>(
            value: selectedYear,
            icon: Icon(Icons.arrow_drop_down),
            underline: Container(),
            onChanged: (String? newValue) {
              setState(() {
                selectedYear = newValue!;
              });
            },
            items: years.map<DropdownMenuItem<String>>((String year) {
              return DropdownMenuItem<String>(
                value: year,
                child: Text(year, style: TextStyle(fontSize: 12, color: Colors.black)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMenu() {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [


            _buildMenuItem('TABLEAU', 0),
            const SizedBox(width: 20),
            _buildMenuItem('RESULTATS', 1),
            const SizedBox(width: 20),
            _buildMenuItem('CALENDRIER', 2),

        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index; // Set selected index
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13,
              fontFamily: "oswald",
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          // Underline only for the selected item
          if (selectedIndex == index)
            Container(
              height: 2,
              width: title.length * 8.0,
              color: Colors.black,
            ),
        ],
      ),
    );
  }

  Widget _buildSelectedContent(Coupe coupe) {
    switch (selectedIndex) {
      case 0:
        print("index test ${coupe.name}");
        return CoupeTableau(coupe: coupe,);
      case 1:
        return CoupeResultats(coupe: coupe,);
      case 2:
        return CoupeCalendar(coupe: coupe,);
      default:
        return Container(); // Fallback in case of unexpected index
    }
  }
}
