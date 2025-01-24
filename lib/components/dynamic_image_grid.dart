import 'package:flutter/material.dart';
import 'package:untitled/models/Moment.dart';
import 'package:video_player/video_player.dart';
import '../screens/ReelsPage.dart';
import 'colors.dart';

class DynamicVideoGrid extends StatefulWidget {
  final List<String> videoPaths;
  final List<String> captions;
  final List<Moment> moments;
  final String text;

  const DynamicVideoGrid({
    Key? key,
    required this.videoPaths,
    required this.captions,
    required this.text,
    required this.moments,
  }) : super(key: key);

  @override
  _DynamicVideoGridState createState() => _DynamicVideoGridState();
}

class _DynamicVideoGridState extends State<DynamicVideoGrid> {
  List<VideoPlayerController> _videoControllers = [];

  @override
  void initState() {
    super.initState();
    _initializeVideoControllers();
  }

  void _initializeVideoControllers() {
    if (widget.videoPaths.isEmpty) {
      print("No video paths provided.");
      return;
    }

    for (var videoPath in widget.videoPaths) {
      VideoPlayerController controller = VideoPlayerController.network(videoPath)
        ..initialize().then((_) {
          setState(() {}); // Ensure the first frame is shown when initialized
        }).catchError((error) {
          print("Error initializing video: $error");
        });
      _videoControllers.add(controller);
    }
  }

  @override
  void dispose() {
    for (var controller in _videoControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> videoPathss = widget.moments.map((moment) => moment.video).toList();
    List<String> captionss = widget.moments.map((moment) => moment.name).toList();

    // Responsive calculations
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double aspectRatio = screenWidth / screenHeight;

    // Determine the number of items per row based on screen width
    int itemsPerRow = screenWidth > 600 ? 3 : 2; // Tablets get 3 items, phones get 2 items

    // Calculate item dimensions based on screen size
    double itemHeight = screenHeight * (screenWidth > 600 ? 0.66 : 0.33);
    double spacing = screenWidth * 0.02;

    // Calculate the number of rows needed
    int numberOfRows = (widget.videoPaths.length / itemsPerRow).ceil();
    //int numberOfRows = 2;

    // Calculate the total height
    double totalHeight = numberOfRows * itemHeight + (numberOfRows - 1) * spacing;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Custom Title with Shadow and Underline
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.text.toUpperCase(),
                style: const TextStyle(
                  fontSize: 24,
                  fontFamily: "oswald",
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: AppColors.textShadow,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Container(
                width: screenWidth > 600 ? screenWidth * 0.155:screenWidth * 0.53, // Dynamic underline width
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textShadow,
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),

          // Video Grid
          SizedBox(
            height: screenWidth > 600 ? totalHeight * 1.3 : totalHeight, // Adjust height for tablets
            child: GridView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: spacing,
                vertical: screenWidth > 600 ? spacing * 0.5 : spacing, // Reduce vertical padding on tablets
              ),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: itemsPerRow,
                crossAxisSpacing: spacing,
                mainAxisSpacing: screenWidth > 600 ? spacing * 0.7 : spacing, // Reduce vertical spacing on tablets
                childAspectRatio: aspectRatio < 1.6 ? 0.6 : 0.5, // Adjust aspect ratio for tablets
              ),
              itemCount: widget.videoPaths.length,
              itemBuilder: (context, index) {
                if (index >= _videoControllers.length) {
                  return const SizedBox(); // Prevent error if controllers are not yet initialized
                }

                final controller = _videoControllers[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: itemHeight * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReelsPage(
                                videoPaths: videoPathss,
                                videoCaptions: captionss,
                                currentIndex: index,
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: controller.value.isInitialized
                                  ? VideoPlayer(controller)
                                  : const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            // Gradient overlay for the fading effect
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.white.withOpacity(0.7),
                                  ],
                                  stops: const [0.3, 1.0],
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: AppColors.imageGridItem,
                                  width: 2.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Icons (Heart and Comment)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Handle like action
                          },
                          icon: Image.asset(
                            'assets/icons/heart.png',
                            fit: BoxFit.scaleDown,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        IconButton(
                          onPressed: () {
                            // Handle comment action
                          },
                          icon: Image.asset(
                            'assets/icons/comment.png',
                            fit: BoxFit.scaleDown,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ],
                    ),

                    // Caption below the icons
                    Text(
                      widget.captions[index],
                      style: const TextStyle(
                        fontSize: 15,
                        fontFamily: "oswald",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}
