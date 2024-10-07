


class NewsItem {
  final String? content;
  final String? imageUrl;
  final String title;
  final DateTime? date;

  NewsItem({
    required this.title,
    this.imageUrl,
    this.content,
    this.date,

  });
}