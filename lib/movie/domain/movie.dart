import 'package:equatable/equatable.dart';

// enum Adult { Pg13, R }

class Movie extends Equatable {
  final String title;
  final String posterPath;
  final int id;
  final double? voteAverage;
  final bool? isAdult;
  final DateTime? releaseDate;
  final String? overview;

  const Movie({
    this.voteAverage,
    this.isAdult,
    this.releaseDate,
    this.overview,
    required this.title,
    required this.posterPath,
    required this.id,
  });

  @override
  List<Object?> get props => [
        title,
        posterPath,
        id,
        voteAverage,
        isAdult,
        releaseDate,
        overview,
      ];
}
