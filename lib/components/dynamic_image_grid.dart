import 'package:flutter/material.dart';
import 'colors.dart';

class DynamicImageGrid extends StatelessWidget {
  final List<String> imagePaths;
  final List<String> captions;

  const DynamicImageGrid({
    Key? key,
    required this.imagePaths,
    required this.captions,
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
                'Meilleur Moments',
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
                width: 220, // Adjust the underline length here
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
              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 1.0,
                childAspectRatio: 0.5,
              ),
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Image Container with gradient and shadow
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white,
                            Colors.black.withOpacity(0.5), // Adjust opacity for fade effect
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.73), // White border color
                          width: 2.0, // Border width
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          imagePaths[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Text(
                                'Image Not Found',
                                style: TextStyle(color: Colors.red),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Comment and Like Icons under the image
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          IconButton(
                            onPressed: () {
                              // Add your like action here
                            },
                            icon: Image.asset(
                              'assets/icons/heart.png', // Replace with your custom search icon
                              fit: BoxFit.scaleDown,
                              width: 20, // Adjust the size here
                              height: 20,


                            ),

                          ),
                          Text(
                            '123K',
                            style: TextStyle(color: Colors.white),
                          ),
                         // const SizedBox(width: 0.0), // Space between icons
                          IconButton(
                            onPressed: () {
                              // Add your comment action here
                            },
                            icon: Image.asset(
                              'assets/icons/comment.png', // Replace with your custom search icon
                              fit: BoxFit.scaleDown,
                              width: 20, // Adjust the size here
                              height: 20,


                            ),
                            iconSize: 20,
                          ),
                          Text(
                            '123K',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                    // Caption under the icons
                    //const SizedBox(height: 4.0),
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
