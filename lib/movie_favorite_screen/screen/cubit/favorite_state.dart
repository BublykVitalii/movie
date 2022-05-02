part of 'favorite_cubit.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteSuccess extends FavoriteState {
  final List<Movie> listMovies;
  FavoriteSuccess({
    required this.listMovies,
  });
}

class FavoriteError extends FavoriteState {}
