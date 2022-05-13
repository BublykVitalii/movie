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
  final String? title;
  final String? description;

  const AddMovieState({
    this.status = AddMovieStatus.initial,
    this.errorMessage,
    this.title = '',
    this.description = '',
  });

  AddMovieState copyWith({
    AddMovieStatus? status,
    String? errorMessage,
    String? title,
    String? description,
  }) {
    return AddMovieState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        title,
        description,
      ];
}
