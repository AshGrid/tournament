import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoComponent extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String description;

  const VideoComponent({
    Key? key,
    required this.videoUrl,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  _VideoComponentState createState() => _VideoComponentState();
}

class _VideoComponentState extends State<VideoComponent> {
  late VideoPlayerController _controller;
  bool _isError = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _isPlaying = _controller.value.isPlaying;
        });
      }).catchError((error) {
        setState(() {
          _isError = true;
        });
        print('VideoPlayer error: $error'); // Print the error for debugging
      });

    _controller.addListener(() {
      if (_controller.value.isPlaying != _isPlaying) {
        setState(() {
          _isPlaying = _controller.value.isPlaying;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      _isPlaying = _controller.value.isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isError) {
      return Center(child: Text('Failed to load video.'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 24, // Adjust font size as needed
              fontWeight: FontWeight.bold,
              color: Colors.white,
              decoration: TextDecoration.underline, // Add underline to the text
              decorationColor: Colors.white, // Customize the underline color
              decorationThickness: 1.0, // Customize the thickness of the underline
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            widget.description,
            style: TextStyle(
              fontSize: 16, // Adjust font size as needed
              color: Colors.grey[600], // Light grey for description
            ),
          ),
        ),
        SizedBox(
          height: 200, // Adjust height as needed
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0), // Set the border radius for rounded corners
            child: Stack(
              children: [
                _controller.value.isInitialized
                    ? VideoPlayer(_controller)
                    : Center(child: CircularProgressIndicator()),
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
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                          ),
                          onPressed: _togglePlayPause,
                        ),
                        Expanded(
                          child: VideoProgressIndicator(
                            _controller,
                            allowScrubbing: true,
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
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
      ],
    );
  }
}
