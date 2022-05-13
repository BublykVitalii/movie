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
  // final String? title;
  // final String? description;
  final List<Movie>? listMovie;

  const MyMovieState({
    this.status = MyMovieStatus.initial,
    this.errorMessage,
    // this.title,
    // this.description,
    this.listMovie,
  });

  MyMovieState copyWith({
    MyMovieStatus? status,
    String? errorMessage,
    // String? title,
    // String? description,
    List<Movie>? listMovie,
  }) {
    return MyMovieState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      // title: title ?? this.title,
      // description: description ?? this.description,
      listMovie: listMovie ?? this.listMovie,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, listMovie];
}
