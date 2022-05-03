part of 'movie_cubit.dart';

enum MovieStatus {
  initial,
  loading,
  success,
  error,
  loadMore,
}

class MovieState extends Equatable {
  final MovieStatus status;

  final List<Movie> movies;
  final bool hasReachedMax;
  final int page;
  final bool isLoadMore;
  final String? errorMessage;

  const MovieState({
    this.status = MovieStatus.initial,
    this.movies = const <Movie>[],
    this.hasReachedMax = false,
    this.page = 1,
    this.isLoadMore = false,
    this.errorMessage,
  });

  MovieState copyWith({
    MovieStatus? status,
    List<Movie>? movies,
    bool? hasReachedMax,
    int? page,
    bool? isLoadMore,
    String? errorMessage,
  }) {
    return MovieState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'MovieState { status: $status, hasReachedMax: $hasReachedMax, movies: ${movies.length}, page: $page , isLoadMore: $isLoadMore}';
  }

  @override
  List<Object?> get props => [
        status,
        movies,
        hasReachedMax,
        page,
        isLoadMore,
        errorMessage,
      ];
}
