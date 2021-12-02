import 'package:wecos_forum/features/view_post/domain/entity/comment.dart';

class CommentModel extends Comment {
  CommentModel({
    required String id,
    required String userId,
    required String username,
    required String content,
    String? imageUrl,
    required DateTime timestamp,
  }) : super(
          id: id,
          userId: userId,
          username: username,
          content: content,
          imageUrl: imageUrl,
          timestamp: timestamp,
        );

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json['id'],
        userId: json['UserId'],
        username: json['User']['username'],
        content: json['content'],
        timestamp: DateTime.parse(json['createdAt']),
        imageUrl: json['imageName'],
      );
}
