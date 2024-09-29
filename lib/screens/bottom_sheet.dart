import 'package:flutter/material.dart';
import 'package:untitled/components/colors.dart';
import '../models/trophy.dart';

class BottomSheetContent extends StatelessWidget {
  final Function(String) onTrophySelected; // Callback function

  BottomSheetContent({Key? key, required this.onTrophySelected}) : super(key: key);

  // Static data for trophies
  final List<Trophy> trophies = [
    Trophy(name: 'TROPHEES DE CARTHAGE'),
    Trophy(name: 'TROPHEES VETERANS'),
    Trophy(name: 'TROPHEES IT'),
    Trophy(name: 'TUNISIA CORPORATE CUP'),
    // Add more trophies as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bottomSheet,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0), // Adjust the radius as needed
          topRight: Radius.circular(10.0), // Adjust the radius as needed
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.bottomSheetShadow, // Shadow color
            offset: const Offset(0, 2), // Shadow position
            blurRadius: 5.9, // How blurry the shadow is
            spreadRadius: 6,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 15),
      height: MediaQuery.of(context).size.height * 0.4, // Set height of the bottom sheet
      width: MediaQuery.of(context).size.width ,

      child: ListView.builder(
        itemCount: trophies.length,
        itemBuilder: (context, index) {
          final trophy = trophies[index];
          // Alternate background colors
          final backgroundColor = index.isEven ? AppColors.bottomSheetItem : AppColors.bottomSheetItem2;

          return Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border(
                bottom: const BorderSide(color: Color(0xFFFFFFFF), width: 2),
                top: index == 0
                    ? const BorderSide(color: Color(0xFFFFFFFF), width: 2)
                    : BorderSide.none,
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              leading: Container(
                width: 55, // Box width
                height: 55, // Box height
                decoration: BoxDecoration(
                  color: Colors.white, // Background color for the box
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
                  border: Border.all(
                    color: AppColors.bottomSheetLogo, // Border color
                    width: 1.0, // Border width
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25), // Shadow color
                      blurRadius: 4.0, // Blur radius
                      spreadRadius: 0.0, // Spread radius
                      offset: const Offset(0, 4), // Shadow position
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0), // Padding inside the box
                  child: Image.asset(
                    'assets/images/${trophy.name}.png', // Adjust path as needed
                    fit: BoxFit.scaleDown, // Adjust image fit
                  ),
                ),
              ),
              title: Text(
                trophy.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20, // Adjust font size as needed
                  fontWeight: FontWeight.bold,
                  fontFamily: "oswald",
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: AppColors.textShadow,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
              ),
              onTap: () {
                onTrophySelected(trophy.name); // Pass the selected trophy name
                Navigator.pop(context); // Close the bottom sheet
              },
            ),
          );
        },
      ),
    );
  }
}
