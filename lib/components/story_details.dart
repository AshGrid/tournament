import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
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
  late PageController _innerPageController; // Controller for images/videos within a story set
  Timer? _autoScrollTimer;
  Timer? _progressTimer;
  int _currentStoryIndex = 0; // Track the current story set index
  int _currentImageIndex = 0; // Track the current image/video index within the set
  bool _isLongPressing = false;
  double _progress = 0.0; // Track progress for the current image/video
  final Duration _imageDuration = const Duration(seconds: 30); // Increased duration for each image/video
  VideoPlayerController? _videoController; // Video player controller
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _currentStoryIndex = widget.initialIndex; // Start at the initial index
    _outerPageController = PageController(initialPage: widget.initialIndex);
    _innerPageController = PageController(initialPage: 0);
    _initializeVideoPlayer();
  }

  void _resetTimers() {
    _autoScrollTimer?.cancel();
    _progressTimer?.cancel();
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
        _progress = 0; // Reset progress for the next image/video
      });
      _innerPageController.animateToPage(
        _currentImageIndex,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
      _resetTimers();
      _initializeVideoPlayer();
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
      _initializeVideoPlayer();
    }
  }

  void _goToNextStorySet() {
    if (_currentStoryIndex < widget.allStories.length - 1) {
      setState(() {
        _currentStoryIndex++;
        _currentImageIndex = 0;
        _progress = 0;
        _innerPageController.jumpToPage(0);
        _isLoading = true; // Reset loading state for the next story set
      });
      _outerPageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
      _initializeVideoPlayer(); // Initialize video for the new story set
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
        _isLoading = true; // Reset loading state for the previous story set
      });
      _outerPageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
      _initializeVideoPlayer(); // Initialize video for the previous story set
    }
  }

  // Function to initialize video player
  void _initializeVideoPlayer() async {
    // Dispose of the current video controller if it exists
    if (_videoController != null) {
      await _videoController!.dispose();
      _videoController = null; // Set it to null after disposing
    }

    if (_currentStoryIndex < widget.allStories.length &&
        _currentImageIndex < widget.allStories[_currentStoryIndex].length) {
      String currentStoryItem = widget.allStories[_currentStoryIndex][_currentImageIndex];
      if (currentStoryItem.endsWith('.mp4') ||
          currentStoryItem.endsWith('.mov') ||
          currentStoryItem.endsWith('.avi') ||
          currentStoryItem.endsWith('.mkv')) {

        _videoController = VideoPlayerController.network(currentStoryItem);
        _videoController!.initialize().then((_) {
          setState(() {
            _isLoading = false; // Set loading to false when video is ready
            _videoController!.play(); // Automatically play video when initialized
          });
          _videoController!.addListener(_videoPlayerListener);
          _startAutoScrollTimer();
          _startProgressTimer();
        }).catchError((error) {
          setState(() {
            _isLoading = false; // Handle any error by stopping the loading
          });
          print('Error initializing video player: $error');
        });
      } else {
        setState(() {
          _isLoading = false; // Set loading to false if it's an image
        });
        _startAutoScrollTimer();
        _startProgressTimer();
      }
    }
  }

  void _videoPlayerListener() {
    if (_videoController != null) {
      if (_videoController!.value.isPlaying) {
        if (_progressTimer == null || !_progressTimer!.isActive) {
          _startProgressTimer(); // Start the progress timer if it's not active
        }
      } else {
        if (_videoController!.value.position >= _videoController!.value.duration) {
          _resetTimers(); // Reset timers if the video is done playing
          _goToNextImage(); // Go to the next image when the video ends
        } else {
          _progressTimer?.cancel(); // Stop the progress timer if the video is paused
        }
      }
    }
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _progressTimer?.cancel();
    _innerPageController.dispose();
    _outerPageController.dispose();
    _videoController?.removeListener(_videoPlayerListener);
    _videoController?.dispose(); // Dispose video controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navbarColor,
      body: GestureDetector(
        onTap: _goToNextImage, // Navigate to the next image on tap
        child: PageView.builder(
          key: ValueKey<int>(_currentStoryIndex), // Use a key to force rebuild
          controller: _outerPageController,
          physics: const ClampingScrollPhysics(),
          itemCount: widget.allStories.length,
          onPageChanged: (index) {
            setState(() {
              _currentStoryIndex = index;
              _currentImageIndex = 0; // Reset image index when story set changes
              _progress = 0;
              _isLoading = true; // Set loading to true when changing story set
              _initializeVideoPlayer(); // Initialize video for the new story set
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
                                  MediaQuery.of(context).size.width),
                              height: 2,
                              color: Colors.white,
                            ),
                          )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      // Inner PageView for Images and Videos
                      PageView.builder(
                        controller: _innerPageController,
                        physics: const ClampingScrollPhysics(),
                        itemCount: currentImages.length,
                        itemBuilder: (context, imageIndex) {
                          final mediaItem = currentImages[imageIndex];
                          if (mediaItem.endsWith('.mp4') ||
                              mediaItem.endsWith('.mov') ||
                              mediaItem.endsWith('.avi') ||
                              mediaItem.endsWith('.mkv')) {
                            return AspectRatio(
                                aspectRatio: 16 / 9,
                                child: _isLoading
                                    ? Center(child: CircularProgressIndicator())
                                    : (_videoController != null && _videoController!.value.isInitialized)
                                    ? VideoPlayer(_videoController!)
                                    : Center(child: CircularProgressIndicator())); // Show loading if video isn't ready
                          } else {
                            return _isLoading
                                ? Center(child: CircularProgressIndicator())
                                : Image.network(
                              mediaItem,
                              fit: BoxFit.cover,
                            );
                          }
                        },
                        onPageChanged: (index) {
                          setState(() {
                            _currentImageIndex = index;
                            _isLoading = true; // Set loading to true when changing image
                            _initializeVideoPlayer(); // Initialize video when switching images
                          });
                          _resetTimers(); // Restart timers for the new image
                        },
                      ),
                      // User Name at the Bottom
                      Positioned(
                        bottom: 40,
                        left: 16,
                        child: Text(
                          widget.userNames[storySetIndex],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}