import 'package:wecos_forum/features/dashboard/domain/entity/post.dart';

class PostModel extends Post {
  PostModel({
    required String id,
    required String title,
    required String content,
    required String imageUrl,
    required DateTime createdAt,
    required String authorId,
    required String authorName,
  }) : super(
          id: id,
          title: title,
          content: content,
          imageUrl: imageUrl,
          createdAt: createdAt,
          authorId: authorId,
          authorName: authorName,
        );

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        imageUrl: json['imageName'],
        createdAt: DateTime.parse(json['createdAt']),
        authorId: json['UserId'],
        authorName: json['User']['username'],
      );
}
