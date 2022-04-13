import 'package:json_annotation/json_annotation.dart';
import 'package:movie/auth/domain/user.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDTO {
  final String username;
  final String password;

  UserDTO({
    required this.username,
    required this.password,
  });

  User toUser() {
    return User(
      username: username,
      password: password,
    );
  }

  Map<String, dynamic> toJson() => _$UserDTOToJson(this);

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);
}
