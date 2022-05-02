import 'package:get_it/get_it.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie/config.dart';
import 'package:movie/user/domain/user.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDTO {
  final int id;
  final String name;
  final Map<String, dynamic> avatar;

  UserDTO({
    required this.id,
    required this.name,
    required this.avatar,
  });

  Map<String, dynamic> toJson() => _$UserDTOToJson(this);

  final _appConfig = GetIt.instance.get<AppConfig>();

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  @override
  String toString() => 'UserDTO(id: $id, name: $name, avatar: $avatar)';

  User toUser() {
    return User(
      name: name,
      avatar: _appConfig.avatarPath + avatar.toString(), // fix
    );
  }
}
