class Comment {
  final String id;
  final String userId;
  final String username;
  final String content;
  final String? imageUrl;
  final DateTime timestamp;

  Comment({
    required this.id,
    required this.userId,
    required this.username,
    required this.content,
    this.imageUrl,
    required this.timestamp,
  });
}
