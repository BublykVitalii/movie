// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesDTO _$MoviesDTOFromJson(Map<String, dynamic> json) => MoviesDTO(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => MovieDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

MovieDTO _$MovieDTOFromJson(Map<String, dynamic> json) => MovieDTO(
      json['title'] as String,
      json['poster_path'] as String,
      json['id'] as int,
      (json['vote_average'] as num).toDouble(),
      json['adult'] as bool,
      json['overview'] as String,
      json['release_date'] as String,
    );
