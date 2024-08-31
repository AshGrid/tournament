import 'package:flutter/material.dart';
import '../components/colors.dart'; // Import the colors file

class NewsSection extends StatelessWidget {
  final List<NewsItem> newsItems;

  const NewsSection({Key? key, required this.newsItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Add "News" title
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Text(
            'News:',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              decoration: TextDecoration.underline, // Add underline to the text
              decorationColor: Colors.white, // Customize the underline color
              decorationThickness: 1.0, // Customize the thickness of the underline// Change the color as per your background
            ),
          ),
        ),

        // Add list of news items
        Column(
          children: newsItems.map((newsItem) => _buildNewsItem(newsItem)).toList(),
        ),
      ],
    );
  }

  Widget _buildNewsItem(NewsItem newsItem) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      constraints: const BoxConstraints(
        minHeight: 120.0, // Set a minimum height for each news item
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
        gradient: AppColors.newsBackground, // Apply the gradient background here
      ),
      child: Align(
        alignment: Alignment.bottomLeft, // Position the text at the bottom left
        child: Text(
          newsItem.title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Text color to contrast with background
          ),
        ),
      ),
    );
  }
}

class NewsItem {
  final String title;

  NewsItem({required this.title});
}
