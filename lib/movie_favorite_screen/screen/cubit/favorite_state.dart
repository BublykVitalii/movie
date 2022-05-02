part of 'favorite_cubit.dart';

enum FavoriteStatus {
  initial,
  loading,
  success,
  error,
}

class FavoriteState {
  final FavoriteStatus? status;
  final List<Movie>? listMovies;
  final String? errorMessage;

  FavoriteState({
    this.listMovies,
    this.status,
    this.errorMessage,
  });

  FavoriteState copyWith({
    FavoriteStatus? status,
    List<Movie>? listMovies,
    String? errorMessage,
  }) {
    return FavoriteState(
      status: status ?? this.status,
      listMovies: listMovies ?? this.listMovies,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'FavoriteState {  status: $status,listMovies: $listMovies, errorMessage: $errorMessage';
  }

  List<Object?> get props => [
        status,
        listMovies,
        errorMessage,
      ];
}
