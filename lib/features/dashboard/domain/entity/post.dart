class Post {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final DateTime createdAt;
  final String authorId;
  final String authorName;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
    required this.authorId,
    required this.authorName,
  });
}
