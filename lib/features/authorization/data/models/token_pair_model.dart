import 'package:wecos_forum/features/authorization/domain/entities/token_pair.dart';

class TokenPairModel extends TokenPair {
  TokenPairModel({
    required String access,
    required String refresh,
  }) : super(access: access, refresh: refresh);

  factory TokenPairModel.fromJson(Map<String, dynamic> json) =>
      TokenPairModel(access: json['access'], refresh: json['refresh']);

  Map<String, dynamic> toJson() => {"access": access, "refresh": refresh};
}
