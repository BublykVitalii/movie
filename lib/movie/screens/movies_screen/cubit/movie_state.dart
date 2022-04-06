part of 'movie_cubit.dart';

enum MovieStatus { initial, loading, success, error }

class MovieState extends Equatable {
  const MovieState({
    this.status = MovieStatus.initial,
    required this.movies,
    this.hasReachedMax = false,
  });

  final MovieStatus status;
  final List<Movie> movies;
  final bool hasReachedMax;

  MovieState copyWith({
    MovieStatus? status,
    List<Movie>? movies,
    bool? hasReachedMax,
  }) {
    return MovieState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return 'MovieState { status: $status, hasReachedMax: $hasReachedMax, movies: ${movies.length} }';
  }

  @override
  List<Object> get props => [status, movies, hasReachedMax];
}





// @immutable
// abstract class MovieState {}

// class MovieInitial extends MovieState {}

// class MovieLoading extends MovieState {}

// class MovieSuccess extends MovieState {
//   final List<Movie>? movies;

//   MovieSuccess({
//     this.movies,
//   });
// }

// class MovieError extends MovieState {}
