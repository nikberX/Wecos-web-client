import 'package:get_it/get_it.dart';
import 'package:wecos_forum/core/service/api/api.dart';
import 'package:wecos_forum/core/service/log_service/logger.dart';
import 'package:wecos_forum/features/view_post/domain/entity/post_with_comments.dart';

class ViewPostRepository {
  Api api;

  ViewPostRepository(this.api);

  PostWithComment? postWithComment;

  Future<void> getPost(String postId) async {
    try {
      postWithComment = await api.getPost(postId);
      GetIt.I.get<Logger>().notice('end', true);
    } catch (e) {
      throw e;
    }
  }
}
