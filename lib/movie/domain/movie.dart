import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String title;
  //@JsonKey(name: 'poster_path')
  final String posterPath;
  final int id;

  const Movie(
    this.title,
    this.posterPath,
    this.id,
  );

  @override
  List<Object?> get props => [title, posterPath, id];
}
