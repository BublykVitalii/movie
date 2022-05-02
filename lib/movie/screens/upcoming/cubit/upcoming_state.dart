part of 'upcoming_cubit.dart';

enum UpcomingStatus {
  initial,
  loading,
  success,
  error,
  loadMore,
}

class UpcomingState extends Equatable {
  final UpcomingStatus status;
  final List<Movie> movies;
  final bool hasReachedMax;
  final int page;
  final bool isLoadMore;
  final String? errorMessage;

  const UpcomingState({
    this.errorMessage,
    this.status = UpcomingStatus.initial,
    this.movies = const <Movie>[],
    this.hasReachedMax = false,
    this.page = 1,
    this.isLoadMore = false,
  });

  UpcomingState copyWith({
    UpcomingStatus? status,
    List<Movie>? movies,
    bool? hasReachedMax,
    int? page,
    bool? isLoadMore,
    String? errorMessage,
  }) {
    return UpcomingState(
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
    return 'UpcomingState { status: $status, hasReachedMax: $hasReachedMax, movies: ${movies.length}, page: $page , isLoadMore: $isLoadMore}';
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
