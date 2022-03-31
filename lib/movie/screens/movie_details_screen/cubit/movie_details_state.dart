part of 'movie_details_cubit.dart';

@immutable
abstract class MovieDetailsState {
  final Movie? movie;
  const MovieDetailsState({
    required this.movie,
  });
}

class MovieDetailsInitial extends MovieDetailsState {
  const MovieDetailsInitial({required Movie movie}) : super(movie: movie);
}

class MovieDetailsLoading extends MovieDetailsState {
  const MovieDetailsLoading({required Movie? movie}) : super(movie: movie);
}

class MovieDetailsSuccess extends MovieDetailsState {
  const MovieDetailsSuccess({required Movie movie}) : super(movie: movie);
}

class MovieDetailsError extends MovieDetailsState {
  const MovieDetailsError({required Movie? movie}) : super(movie: movie);
}
