import 'package:json_annotation/json_annotation.dart';
import 'package:movie/movie/domain/movie.dart';

part 'movie_dto.g.dart';

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

  factory MovieDTO.fromJason(Map<String, dynamic> json) =>
      _$MovieDTOFromJson(json);

  Movie toMovie() {
    return Movie(title, posterPath, id);
  }
}
