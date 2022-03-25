import 'package:json_annotation/json_annotation.dart';
import 'package:movie/movie/domain/movie.dart';

part 'movie_dto.g.dart';

@JsonSerializable(createToJson: false)
class MoviesDTO {
  final int page;
  final List<MovieDTO> results;

  MoviesDTO({
    required this.page,
    required this.results,
  });
  factory MoviesDTO.fromJson(Map<String, dynamic> json) =>
      _$MoviesDTOFromJson(json);
  List<Movie> toMovies() {
    return results
        .map((movie) => Movie(
              id: movie.id,
              posterPath: movie.posterPath,
              title: movie.title,
            ))
        .toList();
  }
}

@JsonSerializable(createToJson: false)
class MovieDTO {
  final String title;
  @JsonKey(name: 'poster_path')
  final String posterPath;
  final int id;

  MovieDTO(
    this.title,
    this.posterPath,
    this.id,
  );

  factory MovieDTO.fromJson(Map<String, dynamic> json) =>
      _$MovieDTOFromJson(json);

  Movie toMovie() {
    return Movie(id: id, posterPath: posterPath, title: title);
  }
}
