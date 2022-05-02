import 'package:json_annotation/json_annotation.dart';
import 'package:movie/user/api/dto/avatar_dto.dart';

import 'package:movie/user/domain/user.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDTO {
  final int id;
  final String name;
  final AvatarDTO avatar;

  UserDTO({
    required this.id,
    required this.name,
    required this.avatar,
  });

  Map<String, dynamic> toJson() => _$UserDTOToJson(this);

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  @override
  String toString() => 'UserDTO(id: $id, name: $name, avatar: $avatar)';

  User toUser() {
    return User(
      name: name,
      avatar: avatar.toAvatar(),
    );
  }
}
