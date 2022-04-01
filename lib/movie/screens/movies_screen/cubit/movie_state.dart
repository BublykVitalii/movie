part of 'movie_cubit.dart';

@immutable
abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieSuccess extends MovieState {
  final List<Movie>? movies;

  MovieSuccess({
    this.movies,
  });
}

class MovieError extends MovieState {}
