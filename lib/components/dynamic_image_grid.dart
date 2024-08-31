import 'package:flutter/material.dart';

class DynamicImageGrid extends StatelessWidget {
  final List<String> imagePaths;

  const DynamicImageGrid({Key? key, required this.imagePaths}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Meilleur Moments',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              decoration: TextDecoration.underline, // Add underline to the text
              decorationColor: Colors.white, // Customize the underline color
              decorationThickness: 1.0, // Customize the thickness of the underline
            ),
          ),
          const SizedBox(height: 8.0),
          // Use GridView to display the images in a 2x2 grid
          SizedBox(
            height: 200, // Adjust the height as needed
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0, // Padding between images horizontally
                mainAxisSpacing: 8.0, // Padding between images vertically
              ),
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      imagePaths[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
