import 'package:wecos_forum/features/dashboard/domain/entity/post.dart';
import 'package:wecos_forum/features/view_post/domain/entity/comment.dart';

class PostWithComment extends Post {
  final List<Comment> comments;

  PostWithComment({
    required String id,
    required String title,
    required String content,
    required String imageUrl,
    required DateTime createdAt,
    required String authorId,
    required String authorName,
    required this.comments,
  }) : super(
          id: id,
          title: title,
          content: content,
          imageUrl: imageUrl,
          createdAt: createdAt,
          authorId: authorId,
          authorName: authorName,
        );
}
