import 'package:get_it/get_it.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:movie/config.dart';
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
    return results.map((movie) => movie.toMovie()).toList();
  }
}

@JsonSerializable(createToJson: false)
class MovieDTO {
  final String title;
  @JsonKey(name: 'poster_path')
  final String posterPath;
  final int id;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'adult')
  final bool isAdult;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  final String overview;

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

  //  if (isAdult == true) {
  //    return 'R';
  //  } else {return 'Pg 13';
  //  }

  Movie toMovie() {
    return Movie(
      voteAverage: voteAverage,
      isAdult: isAdult,
      releaseDate: DateTime.parse(releaseDate),
      overview: overview,
      id: id,
      posterPath: _appConfig.posterUrl + posterPath,
      title: title,
    );
  }
}

// String parseEnumToString(Adult isAdult) {
//   switch (isAdult) {
//     case Adult.Pg13:
//       return 'Pg 13';

//     case Adult.R:
//       return 'R';
//   }
// }

