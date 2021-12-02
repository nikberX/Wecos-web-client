import 'package:wecos_forum/features/view_post/data/models/comment_model.dart';
import 'package:wecos_forum/features/view_post/domain/entity/post_with_comments.dart';

class PostWithCommentsModel extends PostWithComment {
  PostWithCommentsModel({
    required String id,
    required String title,
    required String content,
    required String imageUrl,
    required DateTime createdAt,
    required String authorId,
    required String authorName,
    required List<CommentModel> comments,
  }) : super(
          id: id,
          title: title,
          content: content,
          imageUrl: imageUrl,
          createdAt: createdAt,
          authorId: authorId,
          authorName: authorName,
          comments: comments,
        );

  factory PostWithCommentsModel.fromJson(Map<String, dynamic> json) =>
      PostWithCommentsModel(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        imageUrl: json['imageName'],
        createdAt: DateTime.parse(json['createdAt']),
        authorId: json['UserId'],
        authorName: json['User']['username'],
        comments: json['Comments'] == null
            ? []
            : (json['Comments'] as List)
                .map((json) => CommentModel.fromJson(json))
                .toList(),
      );
}
