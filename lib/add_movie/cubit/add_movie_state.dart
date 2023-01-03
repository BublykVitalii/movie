part of 'add_movie_cubit.dart';

enum AddMovieStatus {
  initial,
  loading,
  success,
  error,
}

class AddMovieState extends Equatable {
  final AddMovieStatus status;
  final String? errorMessage;
  final Movie? movie;

  const AddMovieState({
    this.status = AddMovieStatus.initial,
    this.errorMessage,
    this.movie,
  });

  AddMovieState copyWith({
    AddMovieStatus? status,
    String? errorMessage,
    Movie? movie,
  }) {
    return AddMovieState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      movie: movie ?? this.movie,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        movie,
      ];
}
