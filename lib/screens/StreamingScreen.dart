import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../Service/data_service.dart';
import '../models/Stream.dart';

class StreamingScreen extends StatefulWidget {
  const StreamingScreen({Key? key}) : super(key: key);

  @override
  _StreamingScreenState createState() => _StreamingScreenState();
}

class _StreamingScreenState extends State<StreamingScreen> {
  List<StreamItem> streamItems = [];
  final DataService dataService = DataService();
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _fetchStreams();
  }

  Future<void> _fetchStreams() async {
    try {
      final items = await dataService.fetchStream(); // Assuming you have this method
      setState(() {
        streamItems = items;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isError = true;
        _isLoading = false;
      });
      print('Error fetching streams: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator(color: Colors.white));
    }

    if (_isError) {
      return Center(
        child: Text(
          'Failed to load streams.',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,

      body: ListView.builder(
        itemCount: streamItems.length,
        itemBuilder: (context, index) {
          return VideoComponent(streamItem: streamItems[index]);
        },
      ),
    );
  }
}

class VideoComponent extends StatefulWidget {
  final StreamItem streamItem; // Pass the individual stream item
  const VideoComponent({Key? key, required this.streamItem}) : super(key: key);

  @override
  _VideoComponentState createState() => _VideoComponentState();
}

class _VideoComponentState extends State<VideoComponent> {
  late VideoPlayerController _videoController;
  late YoutubePlayerController _youtubeController;
  bool _isYoutube = false;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    String videoUrl = widget.streamItem.url;
    if (YoutubePlayer.convertUrlToId(videoUrl) != null) {
      _isYoutube = true;
      String videoId = YoutubePlayer.convertUrlToId(videoUrl)!;
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: false),
      );
    } else {
      _isYoutube = false;
      _videoController = VideoPlayerController.network(videoUrl);
      await _videoController.initialize();
      setState(() {});
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
    _isVisible = info.visibleFraction > 0;
    if (_isYoutube) {
      _isVisible ? _youtubeController.play() : _youtubeController.pause();
    } else {
      _isVisible ? _videoController.play() : _videoController.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.streamItem.id.toString()), // Use unique key for visibility
      onVisibilityChanged: _onVisibilityChanged,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: _isYoutube
            ? YoutubePlayer(
          controller: _youtubeController,
          showVideoProgressIndicator: true,
        )
            : ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: VideoPlayer(_videoController),
        ),
      ),
    );
  }
}
