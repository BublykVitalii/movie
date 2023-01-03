import 'package:equatable/equatable.dart';

enum AgeLimit { pgThirteen, r }

class Movie extends Equatable {
  final String? title;
  final String? posterPath;
  final int? id;
  final double? voteAverage;
  final AgeLimit? isAdult;
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

  String adultToString(AgeLimit? ageLimit) {
    switch (ageLimit) {
      case AgeLimit.pgThirteen:
        return 'PG-13';
      case AgeLimit.r:
      default:
        return 'R';
    }
  }
}
