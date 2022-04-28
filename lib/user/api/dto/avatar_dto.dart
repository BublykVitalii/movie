import 'package:json_annotation/json_annotation.dart';
import 'package:movie/user/domain/user.dart';

part 'avatar_dto.g.dart';

@JsonSerializable()
class AvatarDTO {
  final GravatarDTO gravatar;

  AvatarDTO({
    required this.gravatar,
  });

  Map<String, dynamic> toJson() => _$AvatarDTOToJson(this);

  factory AvatarDTO.fromJson(Map<String, dynamic> json) =>
      _$AvatarDTOFromJson(json);

  @override
  String toString() => 'AvatarDTO(gravatar: $gravatar)';

  Avatar toAvatar() {
    return Avatar(gravatar: gravatar.toGravatar());
  }
}

@JsonSerializable()
class GravatarDTO {
  final String hash;

  GravatarDTO({
    required this.hash,
  });

  Map<String, dynamic> toJson() => _$GravatarDTOToJson(this);

  factory GravatarDTO.fromJson(Map<String, dynamic> json) =>
      _$GravatarDTOFromJson(json);

  @override
  String toString() => 'GravatarDTO(hash: $hash)';

  Gravatar toGravatar() {
    return Gravatar(hash: hash);
  }
}
