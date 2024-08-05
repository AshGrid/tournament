import 'dart:async';
import 'package:flutter/material.dart';

class AdsBanner extends StatefulWidget {
  const AdsBanner({super.key});

  @override
  _AdsBannerState createState() => _AdsBannerState();
}

class _AdsBannerState extends State<AdsBanner> {
  final PageController _pageController = PageController();
  final List<String> _adImages = [
    'assets/images/itachi.jpg',
    'assets/images/itachi.jpg',
    'assets/images/jabami.jpg',
    // Add more ad image URLs here
  ];
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startImageRotation();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startImageRotation() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < _adImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _adImages.length,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            child: Image.asset(
              _adImages[index],
              fit: BoxFit.cover,
            ),
          );
        },
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }
}
