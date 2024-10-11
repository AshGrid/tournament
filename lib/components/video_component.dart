import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../Service/data_service.dart';
import '../models/Stream.dart';

class VideoComponent extends StatefulWidget {
  const VideoComponent({Key? key}) : super(key: key);

  @override
  _VideoComponentState createState() => _VideoComponentState();
}

class _VideoComponentState extends State<VideoComponent> {
  late VideoPlayerController _videoController;
  late YoutubePlayerController _youtubeController;
  bool _isError = false;
  bool _isLoading = true;
  bool _isYoutube = false;
  bool _isVisible = true; // Track visibility

  final DataService dataService = DataService();
  List<StreamItem> streamItems = [];

  @override
  void initState() {
    super.initState();
    _fetchStream();
  }

  Future<void> _fetchStream() async {
    try {
      final streamItem = await dataService.fetchStream();
      setState(() {
        streamItems = streamItem;
        _isLoading = false;
      });

      // Check if the URL is a valid YouTube link
      String videoUrl = streamItems[0].url;
      if (YoutubePlayer.convertUrlToId(videoUrl) != null) {
        _isYoutube = true;
        String videoId = YoutubePlayer.convertUrlToId(videoUrl)!;
        _youtubeController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false, // Changed to false for manual control
            mute: false,
          ),
        );
      } else {
        _isYoutube = false;
        _videoController = VideoPlayerController.network(videoUrl);
        await _videoController.initialize();
        setState(() {});
      }
    } catch (error) {
      setState(() {
        _isError = true;
        _isLoading = false;
      });
      print('Error fetching stream: $error');
    }
  }

  @override
  void dispose() {
    if (_isYoutube) {
      _youtubeController.dispose();
    } else {
      _videoController.dispose();
    }
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    // Check if the video component is visible
    setState(() {
      _isVisible = info.visibleFraction > 0;
    });

    // Play or pause based on visibility
    if (_isYoutube) {
      if (_isVisible) {
        _youtubeController.play();
      } else {
        _youtubeController.pause();
      }
    } else {
      if (_isVisible) {
        _videoController.play();
      } else {
        _videoController.pause();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isError) {
      return Center(
        child: Text(
          'Failed to load video.',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(color: Colors.white,),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VisibilityDetector(
          key: Key('video-key'),
          onVisibilityChanged: _onVisibilityChanged,
          child: SizedBox(
            height: MediaQuery.of(context).size.width > 600
                ? MediaQuery.of(context).size.height * 0.7
                : MediaQuery.of(context).size.height * 0.225,
            child: _isYoutube
                ? YoutubePlayer(
              controller: _youtubeController,
              showVideoProgressIndicator: true,
              onReady: () {
                // Optional: Add your logic here if needed
              },
            )
                : ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                children: [
                  VideoPlayer(_videoController),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black54,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              _videoController.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _videoController.value.isPlaying
                                    ? _videoController.pause()
                                    : _videoController.play();
                              });
                            },
                          ),
                          Expanded(
                            child: VideoProgressIndicator(
                              _videoController,
                              allowScrubbing: true,
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
