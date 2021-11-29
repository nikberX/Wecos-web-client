import 'package:equatable/equatable.dart';
import 'package:wecos_forum/core/constants/enums.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, email, imageUrl, createdAt];
}
