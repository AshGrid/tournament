import 'package:flutter/material.dart';
import '../components/colors.dart';
import '../models/News.dart';
import 'package:html_unescape/html_unescape.dart';

class NewsDetails extends StatelessWidget {
  final News newsItem;

   NewsDetails({Key? key, required this.newsItem}) : super(key: key);


  final unescape = HtmlUnescape();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(context),
          _buildNewsContent(context),
        ],
      ),
    );
  }

  Widget _buildHeader(context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                "News:",
                style: const TextStyle(
                  fontSize: 25,
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
              Container(
                width: MediaQuery.of(context).size.width*0.16,
                height: 2,
                color: Colors.white,
              )
            ],
          )
        ],
      )
    );
  }

  Widget _buildNewsContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,

      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Column(
        children: [
          _buildTitleAndDate(),
          _buildImage(context),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildTitleAndDate() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align title to the start (left)
        children: [
          // Title on the left
          Text(
            newsItem.title,
            style: const TextStyle(
              fontSize: 20,
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
          const SizedBox(height: 8), // Add some space between title and date
          // Date on the right
          Row(
            mainAxisAlignment: MainAxisAlignment.end, // Align date to the right
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _formatDate(newsItem.date!),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
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
                  const SizedBox(height: 2), // Optional: space between date and underline
                  Container(
                    width: 85,
                    height: 2,
                    color: Colors.white, // Underline below the date
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }




  Widget _buildImage(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.25,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          newsItem.image ?? 'assets/placeholder.png', // Placeholder image
          fit: BoxFit.fill,
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
    );
  }

  Widget _buildContent() {
    final String decodedContent = unescape.convert(newsItem.content);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded( // Use Expanded to allow the text to take available space
            child: Text(
              decodedContent ?? 'Content not available',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
              textAlign: TextAlign.left,
              maxLines: 50, // Set a maximum number of lines
              overflow: TextOverflow.ellipsis, // Use ellipsis for overflowing text
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildGradientOverlay() {
    return Container(
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
        borderRadius: BorderRadius.circular(20), // Match the border radius
       
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Format the date as needed (e.g., using DateFormat from intl package)
    return '${date.day}/${date.month}/${date.year}'; // Simple example
  }
}
