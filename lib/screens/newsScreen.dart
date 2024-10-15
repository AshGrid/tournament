import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For decoding JSON
import '../Service/data_service.dart';
import '../components/colors.dart';
import '../models/News.dart'; // Adjust the import as per your project structure

class NewsScreen extends StatefulWidget {
  final Function(News) onNewsSelected;
  const NewsScreen({
    Key? key,
     required bool onNewsTapped, required this.onNewsSelected,

  }) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<News> newsList = [];
  bool _isLoading = true;
  String? _errorMessage;
  final DataService dataService = DataService();

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    try {
      final fetchedNews = await dataService.fetchNews();
      setState(() {
        newsList = fetchedNews;
        _isLoading = false; // Set loading to false after fetching
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load news';
        _isLoading = false; // Stop loading on error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: AppColors.backgroundColor, // Use the gradient here
      ),
      child: SingleChildScrollView( // Make the whole view scrollable
        child: Column(
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
                    width: 60, // Adjust width for underline
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

            // Display loading indicator or news items
            _isLoading
                ? Center(
              child: CircularProgressIndicator(color: Colors.white), // Loading indicator
            )
                : Column(
              children: newsList.map((newsItem) => _buildNewsItem(newsItem, context)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsItem(News newsItem, BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("title");
        print(newsItem.content);
        widget.onNewsSelected(newsItem); // Pass the selected news item
      },
      child: Container(
        height: MediaQuery.of(context).size.width > 600
            ? MediaQuery.of(context).size.height * 0.5
            : MediaQuery.of(context).size.height * 0.225,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
        ),
        child: Stack(
          children: [
            // Display news image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  newsItem.image!, // Assuming this now holds a URL string
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Icon(Icons.error)); // Display an error icon if the image fails to load
                  },
                ),
              ),
            ),
            // Gradient overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.newsBackground,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            // News title positioned at the bottom left
            Positioned(
              bottom: 16,
              left: 16,
              child: Text(
                newsItem.title,
                maxLines: 3, // Set a maximum number of lines
                overflow: TextOverflow.ellipsis, // Use ellipsis for overflowing text
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
                textDirection: TextDirection.ltr, // Set text direction to left-to-right
              ),
            ),
          ],
        ),
      ),
    );
  }
}