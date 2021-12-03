import 'package:get_it/get_it.dart';
import 'package:wecos_forum/core/service/http_client.dart/http_client.dart';
import 'package:wecos_forum/core/service/log_service/logger.dart';
import 'package:wecos_forum/core/utils/paginative.dart';
import 'package:wecos_forum/features/authorization/data/models/token_pair_model.dart';
import 'package:wecos_forum/features/authorization/data/models/user_model.dart';
import 'package:wecos_forum/features/authorization/domain/entities/token_pair.dart';
import 'package:wecos_forum/features/dashboard/data/models/post_model.dart';
import 'package:wecos_forum/features/view_post/data/models/post_with_comments_model.dart';

class Api {
  HttpClient httpClient;

  Api(this.httpClient);

  ///
  ///Auth
  ///

  Future<TokenPair> register(
      String email, String username, String password, String? imageUrl) async {
    final response = await httpClient.post(
      '/auth/sign-up',
      {
        "email": email,
        "password": password,
        "username": email,
        "imageName": imageUrl,
      },
    );
    return TokenPairModel.fromJson(response!.data['result']);
  }

  Future<TokenPair> login(String email, String password) async {
    final response = await httpClient.post(
      '/auth/sign-in',
      {
        "email": email,
        "password": password,
      },
    );
    return TokenPairModel.fromJson(response!.data['result']);
  }

  Future<UserModel> profile() async {
    final response = await httpClient.get('/profile/me');
    return UserModel.fromJson(response!.data['user']);
  }

  Future<Paginative<List<PostModel>>> getPosts(
      [int limit = 10, int offset = 0]) async {
    final response = await httpClient.get(
      '/posts',
      {
        'limit': limit,
        'offset': offset,
      },
    );
    return Paginative(
      response!.data['result']['count'],
      (response.data['result']['rows'] as List)
          .map((json) => PostModel.fromJson(json))
          .toList(),
    );
  }

  Future<PostWithCommentsModel> getPost(String postId) async {
    final result = await httpClient.get('/posts/$postId');
    return PostWithCommentsModel.fromJson(result!.data['result']);
  }

  Future<String> createPost(
      String imageUrl, String title, String content) async {
    final result = await httpClient.post('/posts/create-post', {
      'imageName': imageUrl,
      'title': title,
      'content': content,
    });

    return result!.data['postId'];
  }

  Future<void> createComment(
      String postId, String imageUrl, String content) async {
    final result = await httpClient.post('/posts/$postId/create-comment', {
      'imageName': imageUrl,
      'content': content,
    });
  }
}
