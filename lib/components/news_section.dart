import 'package:flutter/material.dart';
import '../components/colors.dart';
import '../models/news.dart';
import '../screens/newsDetails.dart';


class NewsSection extends StatelessWidget {
  final List<NewsItem> newsItems;

  const NewsSection({Key? key, required this.newsItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // "News" title with shadow and underline
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'News',
                style: TextStyle(
                  fontSize: 24.0,
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
                width: 68, // Adjust width for underline
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
        ),

        // List of news items
        Column(
          children: newsItems.map((newsItem) => _buildNewsItem(newsItem, context)).toList(),
        ),
      ],
    );
  }

  Widget _buildNewsItem(NewsItem newsItem, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to NewsDetailsPage on tap
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetails(newsItem: newsItem),
          ),
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.width > 600
            ? MediaQuery.of(context).size.height * 0.5
            : MediaQuery.of(context).size.height * 0.225,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
          gradient: AppColors.newsBackground, // Apply the gradient background
        ),
        child: Stack(
          children: [
            // Display news image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  newsItem.imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // News title positioned at the bottom left
            Positioned(
              bottom: 16,
              left: 16,
              child: Text(
                newsItem.title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Text color to contrast with the image
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
