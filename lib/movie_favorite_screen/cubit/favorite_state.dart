part of 'favorite_cubit.dart';

@immutable
abstract class FavoriteState {
  final Movie? movie;
  const FavoriteState({
    required this.movie,
  });
}

class FavoriteInitial extends FavoriteState {
  const FavoriteInitial({required Movie movie}) : super(movie: movie);
}

class FavoriteLoading extends FavoriteState {
  const FavoriteLoading({required Movie? movie}) : super(movie: movie);
}

class FavoriteSuccess extends FavoriteState {
  const FavoriteSuccess({required Movie movie}) : super(movie: movie);
}

class FavoriteError extends FavoriteState {
  const FavoriteError({required Movie? movie}) : super(movie: movie);
}
