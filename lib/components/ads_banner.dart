import 'package:flutter/material.dart';

import '../Service/data_service.dart';

class AdsBanner extends StatefulWidget {
  const AdsBanner({super.key});

  @override
  _AdsBannerState createState() => _AdsBannerState();
}

class _AdsBannerState extends State<AdsBanner> {
  String? backgroundImage; // URL of the background image fetched from the server
  bool isAdsLoading = true; // Loading state
  final DataService dataService = DataService();
  @override
  void initState() {
    super.initState();
    _fetchAdImage(); // Fetch the background image when the widget initializes
  }

  Future<void> _fetchAdImage() async {
    try {
      final fetchedAds = await dataService.fetchAds();
      setState(() {
        // Filter ads by place and ensure non-null images
        final filteredAds = fetchedAds
            .where((ad) => ad.place == "home" && ad.image != null)
            .toList();

        // Set the background image to the first ad's image
        if (filteredAds.isNotEmpty) {
          backgroundImage = filteredAds.first.image!;
        }

        // Map the filtered ads to their image paths


        isAdsLoading = false; // Set loading to false after fetching ads
      });
    } catch (e) {
      print("Error fetching ads for home screen: $e");
      setState(() {
        isAdsLoading = false; // Stop loading on error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 400,
      // height: MediaQuery.of(context).size.height * 0.08,
      // width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.black12,
          width: 1.0,
        ),
      ),
      child: isAdsLoading
          ? const Center(
        child: CircularProgressIndicator(), // Show loading spinner
      )
          : Stack(
        children: [
          // Background image from the server
          if (backgroundImage != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                backgroundImage!,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          // Logo overlay
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/icons/logo.png',
                height: 40.0,
              ),
            ),
          ),
          // Text overlay (optional)

        ],
      ),
    );
  }
}
