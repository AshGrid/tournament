import 'package:flutter/material.dart';
import 'package:untitled/components/colors.dart';
import 'bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetContent();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    // Add the AdsBanner widget here
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
