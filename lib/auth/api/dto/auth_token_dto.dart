import 'package:json_annotation/json_annotation.dart';

part 'auth_token_dto.g.dart';

@JsonSerializable()
class AuthTokenDTO {
  @JsonKey(name: 'request_token')
  final String? requestToken;

  AuthTokenDTO({
    required this.requestToken,
  });

  Map<String, dynamic> toJson() => _$AuthTokenDTOToJson(this);

  factory AuthTokenDTO.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenDTOFromJson(json);
}
