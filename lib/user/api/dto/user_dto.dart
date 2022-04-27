import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDTO {
  final int id;

  UserDTO({
    required this.id,
  });

  Map<String, dynamic> toJson() => _$UserDTOToJson(this);

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  @override
  String toString() => 'UserDTO(id: $id)';
}
