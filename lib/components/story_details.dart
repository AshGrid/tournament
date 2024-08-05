import 'dart:async';
import 'package:flutter/material.dart';

class StoryDetailScreen extends StatefulWidget {
  final List<String> imageUrls;
  final String userName;

  const StoryDetailScreen({
    Key? key,
    required this.imageUrls,
    required this.userName,
  }) : super(key: key);

  @override
  _StoryDetailScreenState createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  late PageController _pageController;
  Timer? _timer;
  int _currentIndex = 0;
  bool _isLongPressing = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _startAutoScrollTimer();
  }

  void _startAutoScrollTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_isLongPressing) return; // Do not scroll if long pressing
      if (_currentIndex < widget.imageUrls.length - 1) {
        _currentIndex++;
        _pageController.animateToPage(
          _currentIndex,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeIn,
        );
      } else {
        _timer?.cancel();
        Navigator.pop(context); // Close the story view when all images are shown
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentIndex < widget.imageUrls.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.pop(context);
    }
  }

  void _goToPreviousPage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
      ),
      body: GestureDetector(
        onLongPress: () {
          setState(() {
            _isLongPressing = true;
          });
        },
        onLongPressUp: () {
          setState(() {
            _isLongPressing = false;
          });
        },
        onTapUp: (details) {
          final screenWidth = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx < screenWidth / 2) {
            _goToPreviousPage();
          } else {
            _goToNextPage();
          }
        },
        child: PageView.builder(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(), // Disable manual swipe
          itemCount: widget.imageUrls.length,
          itemBuilder: (context, index) {
            return Image.asset(
              widget.imageUrls[index],
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
