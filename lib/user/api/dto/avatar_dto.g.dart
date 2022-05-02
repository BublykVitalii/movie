// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvatarDTO _$AvatarDTOFromJson(Map<String, dynamic> json) => AvatarDTO(
      gravatar: GravatarDTO.fromJson(json['gravatar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AvatarDTOToJson(AvatarDTO instance) => <String, dynamic>{
      'gravatar': instance.gravatar,
    };

GravatarDTO _$GravatarDTOFromJson(Map<String, dynamic> json) => GravatarDTO(
      hash: json['hash'] as String,
    );

Map<String, dynamic> _$GravatarDTOToJson(GravatarDTO instance) =>
    <String, dynamic>{
      'hash': instance.hash,
    };
