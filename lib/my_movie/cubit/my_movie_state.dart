part of 'my_movie_cubit.dart';

enum MyMovieStatus {
  initial,
  loading,
  success,
  error,
}

class MyMovieState extends Equatable {
  final MyMovieStatus status;
  final String? errorMessage;
  final List<Movie>? listMovie;
  final Movie? movie;

  const MyMovieState({
    this.status = MyMovieStatus.initial,
    this.errorMessage,
    this.listMovie,
    this.movie,
  });

  MyMovieState copyWith({
    MyMovieStatus? status,
    String? errorMessage,
    List<Movie>? listMovie,
    Movie? movie,
  }) {
    return MyMovieState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      listMovie: listMovie ?? this.listMovie,
      movie: movie ?? this.movie,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, listMovie];
}
