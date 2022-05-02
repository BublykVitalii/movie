part of 'top_rated_cubit.dart';

enum TopRatedStatus {
  initial,
  loading,
  success,
  error,
  loadMore,
}

class TopRatedState extends Equatable {
  final TopRatedStatus status;
  final List<Movie> movies;
  final bool hasReachedMax;
  final int page;
  final bool isLoadMore;
  final String? errorMessage;

  const TopRatedState({
    this.errorMessage,
    this.status = TopRatedStatus.initial,
    this.movies = const <Movie>[],
    this.hasReachedMax = false,
    this.page = 1,
    this.isLoadMore = false,
  });

  TopRatedState copyWith({
    TopRatedStatus? status,
    List<Movie>? movies,
    bool? hasReachedMax,
    int? page,
    bool? isLoadMore,
    String? errorMessage,
  }) {
    return TopRatedState(
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
    return 'TopRatedState { status: $status, hasReachedMax: $hasReachedMax, movies: ${movies.length}, page: $page , isLoadMore: $isLoadMore}';
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
