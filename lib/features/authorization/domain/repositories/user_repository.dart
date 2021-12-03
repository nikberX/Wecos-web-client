import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecos_forum/core/service/api/api.dart';
import 'package:wecos_forum/core/service/log_service/logger.dart';
import 'package:wecos_forum/features/authorization/domain/entities/token_pair.dart';
import 'package:wecos_forum/features/authorization/domain/entities/user.dart';

class UserRepository {
  final Api api;
  UserRepository(this.api);

  late final User user;
  TokenPair? auth;

  String? get refresh => auth?.refresh;
  String? get access => auth?.access;

  bool get authenticated => auth != null;

  Future<void> register(String email, String username, String password) async {
    auth = await api.register(email, username, password, null);
    await getUserProfile();
    await saveTokens(auth!);
  }

  Future<void> login(String email, String password) async {
    auth = await api.login(email, password);
    await getUserProfile();
    await saveTokens(auth!);
  }

  Future<void> getUserProfile() async {
    user = await api.profile();
  }

  Future<void> saveTokens(TokenPair tokens) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString('access', tokens.access);
    await sp.setString('refresh', tokens.refresh);
  }

  Future<void> checkAuth() async {
    final sp = await SharedPreferences.getInstance();
    String? access = sp.getString('access');
    String? refresh = sp.getString('refresh');
    GetIt.I
        .get<Logger>()
        .info('checking access', access != null && refresh != null);
    if (access != null && refresh != null) {
      auth = TokenPair(access: access, refresh: refresh);
      try {
        await getUserProfile();
      } catch (e) {
        auth = null;
      }
    }
  }
}
