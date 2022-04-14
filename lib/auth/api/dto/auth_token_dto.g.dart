// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthTokenDTO _$AuthTokenDTOFromJson(Map<String, dynamic> json) => AuthTokenDTO(
      requestToken: json['request_token'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$AuthTokenDTOToJson(AuthTokenDTO instance) =>
    <String, dynamic>{
      'request_token': instance.requestToken,
      'username': instance.username,
      'password': instance.password,
    };
