import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String title;
  final String posterPath;
  final int id;
  final double voteAverage;
  final bool adult;
  final String releaseDate;
  final String overview;

  const Movie(
    this.voteAverage,
    this.adult,
    this.releaseDate,
    this.overview, {
    required this.title,
    required this.posterPath,
    required this.id,
  });

  @override
  List<Object?> get props => [title, posterPath, id];
}
