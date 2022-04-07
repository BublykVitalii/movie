part of 'movie_cubit.dart';

enum MovieStatus { initial, loading, success, error }

class MovieState extends Equatable {
  final MovieStatus status;
  final List<Movie> movies;
  final bool hasReachedMax;
  final int page;
  final int totalPage;
  final int totalResults;

  const MovieState({
    this.status = MovieStatus.initial,
    this.movies = const <Movie>[],
    this.hasReachedMax = false,
    this.page = 1,
    this.totalPage = 33,
    this.totalResults = 649,
  });

  MovieState copyWith({
    MovieStatus? status,
    List<Movie>? movies,
    bool? hasReachedMax,
    int? page,
    int? totalPage,
    int? totalResults,
  }) {
    return MovieState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      totalPage: totalPage ?? this.totalPage,
      totalResults: totalResults ?? this.totalResults,
    );
  }

  @override
  String toString() {
    return 'MovieState { status: $status, hasReachedMax: $hasReachedMax, movies: ${movies.length}, page: $page, totalPage: $totalPage, totalResults: $totalResults,}';
  }

  @override
  List<Object> get props => [
        status,
        movies,
        hasReachedMax,
        page,
        totalPage,
        totalResults,
      ];
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
