import 'package:flutter/material.dart';
import 'package:untitled/screens/ReelsPage.dart';
import 'colors.dart';

class DynamicImageGrid extends StatelessWidget {
  final List<String> imagePaths;
  final List<String> captions;
  final String text;

  const DynamicImageGrid({
    Key? key,
    required this.imagePaths,
    required this.captions,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                text.toUpperCase(),
                style: TextStyle(
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
              SizedBox(height: 2), // Space between text and underline
              Container(
                width: text.toUpperCase().length*13, // Adjust the underline length here
                height: 3, // Thickness of the underline
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textShadow,
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 4), // Shadow position for the underline
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),

          // Image Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(5.0),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 20.0,
                childAspectRatio: 0.5,
              ),
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 250,
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => ReelsPage()), // Replace with your main screen
                          // );
                        },
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                imagePaths[index],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Text(
                                      'Image Not Found',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  );
                                },
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
                                  stops: const [0.3, 1.0], // Adjust gradient stop for better fading
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: AppColors.imageGridItem, width: 2.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),

                    // Icons (Heart and Comment) placed under the image
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Add your like action here
                          },
                          icon: Image.asset(
                            'assets/icons/heart.png',
                            fit: BoxFit.scaleDown,
                            width: 20, // Adjust the size here
                            height: 20,
                          ),
                        ),
                        Text("123K",style: const TextStyle(
                          fontSize: 13,
                          fontFamily: "oswald",

                          color: Colors.white,
                        ),),
                        const SizedBox(width: 10.0),

                        // Space between icons
                        IconButton(
                          onPressed: () {
                            // Add your comment action here
                          },
                          icon: Image.asset(
                            'assets/icons/comment.png',
                            fit: BoxFit.scaleDown,
                            width: 20, // Adjust the size here
                            height: 20,
                          ),
                        ),
                        Text("123K",style: const TextStyle(
                          fontSize: 13,
                          fontFamily: "oswald",

                          color: Colors.white,
                        ),),
                      ],
                    ),

                    // Caption below the icons
                    Text(
                      captions[index],
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
