import 'package:wecos_forum/core/service/api/api.dart';
import 'package:wecos_forum/features/authorization/domain/entities/token_pair.dart';
import 'package:wecos_forum/features/authorization/domain/entities/user.dart';

class UserRepository {
  final Api api;
  UserRepository(this.api);

  late final User user;
  TokenPair? auth;

  String? get refresh => auth?.refresh;
  String? get access => auth?.access;

  Future<void> login(String email, String password) async {
    auth = await api.login(email, password);
    await getUserProfile();
  }

  Future<void> getUserProfile() async {
    user = await api.profile();
  }
}
