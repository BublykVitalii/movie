import 'package:json_annotation/json_annotation.dart';

part 'auth_token_dto.g.dart';

@JsonSerializable()
class AuthTokenDTO {
  @JsonKey(name: 'request_token')
  final String? requestToken;
  final String? username;
  final String? password;

  AuthTokenDTO({
    required this.requestToken,
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() => _$AuthTokenDTOToJson(this);

  factory AuthTokenDTO.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenDTOFromJson(json);
}
