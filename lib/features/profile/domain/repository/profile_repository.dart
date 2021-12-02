import 'package:wecos_forum/core/service/api/api.dart';
import 'package:wecos_forum/features/authorization/domain/entities/token_pair.dart';
import 'package:wecos_forum/features/authorization/domain/entities/user.dart';
import 'package:wecos_forum/features/authorization/domain/repositories/user_repository.dart';

class ProfileRepository {
  Api api;
  UserRepository userRepository;

  ProfileRepository(this.api, this.userRepository);

  User? user;

  Future<void> getUser([String? userId]) async {
    if (userId == null) {
      await _getCurrentUser();
    } else {
      await _getForeignUser(userId);
    }
  }

  Future<void> _getForeignUser([String? userId]) async {
    //TODO: add method to back-end and to api class
    user = await api.profile();
  }

  Future<void> _getCurrentUser() async {
    if (userRepository.auth != null) {
      user = userRepository.user;
    } else
      return;
  }
}
