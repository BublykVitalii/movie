import 'package:json_annotation/json_annotation.dart';

part 'favorite_data_dto.g.dart';

enum MediaType { movie, tv }

@JsonSerializable()
class FavoriteDataDTO {
  final bool favorite;
  @JsonKey(name: 'media_type')
  final MediaType mediaType;
  @JsonKey(name: 'media_id')
  final int mediaId;

  FavoriteDataDTO({
    required this.favorite,
    required this.mediaType,
    required this.mediaId,
  });

  Map<String, dynamic> toJson() => _$FavoriteDataDTOToJson(this);

  factory FavoriteDataDTO.fromJson(Map<String, dynamic> json) =>
      _$FavoriteDataDTOFromJson(json);
}
