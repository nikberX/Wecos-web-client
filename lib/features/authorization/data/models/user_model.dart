import 'package:wecos_forum/core/constants/enums.dart';
import 'package:wecos_forum/features/authorization/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String name,
    required String email,
    required String imageUrl,
    required DateTime createdAt,
    required Language language,
  }) : super(
    id: id, 
    name: name, 
    email: email, 
    imageUrl: imageUrl, 
    createdAt: createdAt, 
    language: language,
    );

}