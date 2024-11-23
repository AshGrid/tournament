import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:video_player/video_player.dart';
import '../components/colors.dart';
import 'StoryViewScreen.dart';

class StoryPageScreen extends StatefulWidget {
  final List<List<String>> allStories;
  final List<String> userNames;
  final int initialIndex;

  StoryPageScreen({
    Key? key,
    required this.allStories,
    required this.userNames,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  _StoryPageScreenState createState() => _StoryPageScreenState();
}

class _StoryPageScreenState extends State<StoryPageScreen> {
  late StoryController _storyController;
  late List<StoryItem> storyItems;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _storyController = StoryController();
    currentIndex = widget.initialIndex;
    _loadStorySet();
  }

  void _loadStorySet() {
    storyItems = widget.allStories[currentIndex].map((mediaUrl) {
      if (isVideo(mediaUrl)) {
        VideoPlayerController videoController = VideoPlayerController.network(mediaUrl);
        videoController.addListener(() {
          if (videoController.value.isBuffering) {
            _storyController.pause();
          } else if (videoController.value.isInitialized && !videoController.value.isBuffering) {
            // Check if video is fully buffered before resuming
            if (videoController.value.position >= videoController.value.buffered.last.end) {
              _storyController.play();
            }
          }
        });
        return StoryItem.pageVideo(
          mediaUrl,
          controller: _storyController,
          duration: Duration(seconds: 15),
        );
      } else {
        return StoryItem.pageImage(
          url: mediaUrl,
          controller: _storyController,
          duration: Duration(seconds: 8),
        );
      }
    }).toList();
    setState(() {}); // Trigger rebuild with updated storyItems
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navbarColor,
      body: FutureBuilder<void>(
        future: Future.value(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return StoryViewScreen(
            storyItems: storyItems,
            controller: _storyController,
            onComplete: _onComplete,
          );
        },
      ),
    );
  }

  void _onComplete() {
    if (currentIndex < widget.allStories.length - 1) {
      setState(() {
        currentIndex++;
        _loadStorySet(); // Reload with a new set of items for the next user
      });
    } else {
      Navigator.pop(context); // Exit when all stories are done
    }
  }

  @override
  void dispose() {
    _storyController.dispose();
    super.dispose();
  }

  bool isVideo(String url) {
    return url.endsWith(".mp4") || url.endsWith(".mov") || url.endsWith(".avi") || url.endsWith(".mkv");
  }
}