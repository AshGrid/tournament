import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untitled/components/colors.dart';

class StoryDetailScreen extends StatefulWidget {
  final List<List<String>> allStories; // All stories as a list of image sets
  final List<String> userNames; // Corresponding usernames
  final int initialIndex; // Index of the first story set to display

  const StoryDetailScreen({
    Key? key,
    required this.allStories,
    required this.userNames,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  _StoryDetailScreenState createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  late PageController _outerPageController; // Controller for story sets
  late PageController _innerPageController; // Controller for images within a story set
  Timer? _autoScrollTimer;
  Timer? _progressTimer;
  int _currentStoryIndex = 0; // Track the current story set index
  int _currentImageIndex = 0; // Track the current image index within the set
  bool _isLongPressing = false;
  double _progress = 0.0; // Track progress for the current image
  final Duration _imageDuration = const Duration(seconds: 3); // Duration for each image

  @override
  void initState() {
    super.initState();
    _currentStoryIndex = widget.initialIndex; // Start at the initial index
    _outerPageController = PageController(initialPage: widget.initialIndex);
    _innerPageController = PageController(initialPage: 0);

    _startAutoScrollTimer();
    _startProgressTimer();
  }

  void _resetTimers() {
    _autoScrollTimer?.cancel();
    _progressTimer?.cancel();
    _progress = 0.0; // Reset progress
    _startAutoScrollTimer();
    _startProgressTimer();
  }

  void _startAutoScrollTimer() {
    _autoScrollTimer = Timer.periodic(_imageDuration, (Timer timer) {
      if (_isLongPressing) return; // Do not scroll if long pressing
      _goToNextImage();
    });
  }

  void _startProgressTimer() {
    _progressTimer = Timer.periodic(const Duration(milliseconds: 50), (Timer timer) {
      if (_isLongPressing) return; // Do not update progress if long pressing
      setState(() {
        _progress += 50 / _imageDuration.inMilliseconds; // Increment progress
        if (_progress >= 1) {
          _progress = 0; // Reset progress
        }
      });
    });
  }

  void _goToNextImage() {
    if (_currentImageIndex < widget.allStories[_currentStoryIndex].length - 1) {
      setState(() {
        _currentImageIndex++;
        _progress = 0; // Reset progress for the next image
      });
      _innerPageController.animateToPage(
        _currentImageIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
      _resetTimers();
    } else {
      _goToNextStorySet();
    }
  }

  void _goToPreviousImage() {
    if (_currentImageIndex > 0) {
      setState(() {
        _currentImageIndex--;
        _progress = 0;
      });
      _innerPageController.animateToPage(
        _currentImageIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
      _resetTimers();
    }
  }

  void _goToNextStorySet() {
    if (_currentStoryIndex < widget.allStories.length - 1) {
      setState(() {
        _currentStoryIndex++;
        _currentImageIndex = 0;
        _progress = 0;
        _innerPageController.jumpToPage(0);
      });
      _outerPageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
      _resetTimers();
    } else {
      _autoScrollTimer?.cancel();
      _progressTimer?.cancel();
      Navigator.pop(context); // Exit when all story sets are viewed
    }
  }

  void _goToPreviousStorySet() {
    if (_currentStoryIndex > 0) {
      setState(() {
        _currentStoryIndex--;
        _currentImageIndex = 0;
        _progress = 0;
        _innerPageController.jumpToPage(0);
      });
      _outerPageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
      _resetTimers();
    }
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _progressTimer?.cancel();
    _innerPageController.dispose();
    _outerPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navbarColor,
      body: PageView.builder(
        controller: _outerPageController,
        physics: const ClampingScrollPhysics(),
        itemCount: widget.allStories.length,
        onPageChanged: (index) {
          setState(() {
            _currentStoryIndex = index;
            _currentImageIndex = 0; // Reset image index when story set changes
            _progress = 0;
          });
          _resetTimers(); // Restart timers for the new story set
        },
        itemBuilder: (context, storySetIndex) {
          final currentImages = widget.allStories[storySetIndex];

          return Column(
            children: [
              // Top Progress Bar
              Container(
                height: 5,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: List.generate(
                    currentImages.length,
                        (index) => Expanded(
                      child: Container(
                        height: 2,
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          color: index < _currentImageIndex
                              ? Colors.grey
                              : Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                        child: index == _currentImageIndex
                            ? Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: (_progress *
                                MediaQuery.of(context).size.width /
                                currentImages.length),
                            color: Colors.grey,
                          ),
                        )
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
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
                      _goToPreviousImage();
                    } else {
                      _goToNextImage();
                    }
                  },
                  child: PageView.builder(
                    controller: _innerPageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: currentImages.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        currentImages[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
