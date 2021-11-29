import 'package:wecos_forum/core/constants/enums.dart';
import 'package:wecos_forum/features/authorization/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String name,
    required String email,
    required String imageUrl,
    required DateTime createdAt,
  }) : super(
          id: id,
          name: name,
          email: email,
          imageUrl: imageUrl,
          createdAt: createdAt,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['username'],
        email: json['email'],
        imageUrl: json['imageName'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": name,
        "email": email,
        "imageName": imageUrl,
        "createdAt": createdAt.toIso8601String(),
      };
}
