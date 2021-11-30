import 'package:wecos_forum/core/service/http_client.dart/http_client.dart';
import 'package:wecos_forum/core/utils/paginative.dart';
import 'package:wecos_forum/features/authorization/data/models/token_pair_model.dart';
import 'package:wecos_forum/features/authorization/data/models/user_model.dart';
import 'package:wecos_forum/features/authorization/domain/entities/token_pair.dart';
import 'package:wecos_forum/features/dashboard/data/models/post_model.dart';

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
}
