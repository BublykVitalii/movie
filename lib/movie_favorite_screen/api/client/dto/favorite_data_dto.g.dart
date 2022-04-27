// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteDataDTO _$FavoriteDataDTOFromJson(Map<String, dynamic> json) =>
    FavoriteDataDTO(
      favorite: json['favorite'] as bool,
      mediaType: $enumDecode(_$MediaTypeEnumMap, json['media_type']),
      mediaId: json['media_id'] as int,
    );

Map<String, dynamic> _$FavoriteDataDTOToJson(FavoriteDataDTO instance) =>
    <String, dynamic>{
      'favorite': instance.favorite,
      'media_type': _$MediaTypeEnumMap[instance.mediaType],
      'media_id': instance.mediaId,
    };

const _$MediaTypeEnumMap = {
  MediaType.movie: 'movie',
  MediaType.tv: 'tv',
};
