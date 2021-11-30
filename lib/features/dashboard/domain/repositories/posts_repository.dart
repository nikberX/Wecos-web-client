import 'package:dio/dio.dart';
import 'package:wecos_forum/core/service/api/api.dart';
import 'package:wecos_forum/features/dashboard/domain/entity/post.dart';

class PostsRepository {
  final Api api;

  PostsRepository(this.api);

  bool get initialized => posts.isNotEmpty || canLoadMore == false;

  List<Post> posts = [];

  bool canLoadMore = true;

  Future<void> getPosts() async {
    if (!canLoadMore) return;
    try {
      final postsPaginative = await api.getPosts(10, posts.length);
      if (postsPaginative.count <= posts.length) {
        canLoadMore = false;
      }
      posts.addAll(postsPaginative.data);
    } on DioError catch (e) {
    } catch (e) {}
  }

  Future<void> refresh() async {
    posts = [];
    canLoadMore = true;
    await getPosts();
  }
}
