import 'package:get_it/get_it.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:movie/config.dart';
import 'package:movie/movie/domain/movie.dart';

part 'movie_dto.g.dart';

@JsonSerializable(createToJson: false)
class MoviesDTO {
  final int page;
  final List<MovieDTO> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  MoviesDTO({
    required this.page,
    required this.results,
    required this.totalResults,
    required this.totalPages,
  });
  factory MoviesDTO.fromJson(Map<String, dynamic> json) =>
      _$MoviesDTOFromJson(json);
  List<Movie> toMovies() {
    return results.map((movie) => movie.toMovie()).toList();
  }
}

@JsonSerializable(createToJson: false)
class MovieDTO {
  final String? title;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  final int id;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'adult')
  final bool isAdult;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  final String? overview;

  MovieDTO(
    this.title,
    this.posterPath,
    this.id,
    this.voteAverage,
    this.isAdult,
    this.overview,
    this.releaseDate,
  );

  final _appConfig = GetIt.instance.get<AppConfig>();

  factory MovieDTO.fromJson(Map<String, dynamic> json) =>
      _$MovieDTOFromJson(json);

  Movie toMovie() {
    return Movie(
      voteAverage: voteAverage,
      isAdult: _parseAgeLimit(isAdult),
      releaseDate: releaseDate.isNotEmpty ? DateTime.parse(releaseDate) : null,
      overview: overview ?? '--',
      id: id,
      posterPath: posterPath != null ? _appConfig.posterUrl + posterPath! : '',
      title: title ?? '-',
    );
  }

  AgeLimit? _parseAgeLimit(bool isAdult) {
    switch (isAdult) {
      case true:
        return AgeLimit.r;
      case false:
      default:
        return AgeLimit.pgThirteen;
    }
  }
}
