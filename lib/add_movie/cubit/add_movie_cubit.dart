import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/add_movie/domain/movie.dart';

part 'add_movie_state.dart';

class AddMovieCubit extends Cubit<AddMovieState> {
  AddMovieCubit() : super(const AddMovieState());
  final List<Movie> _listMovie = <Movie>[
    Movie(
      title: 'Dogma',
      description: 'Welcome to hell',
      id: 0,
    ),
    Movie(
      title: 'Doctor who?',
      description: 'Welcome to summer',
      id: 1,
    ),
  ];

  List<Movie> get listMovie => _listMovie;

  void saveTitleDescription(String title, String description) {
    emit(state.copyWith(
      title: title,
      description: description,
      status: AddMovieStatus.success,
    ));
  }

  void addMovie(Movie movie) {
    emit(state.copyWith(status: AddMovieStatus.loading));
    _listMovie.add(movie);
    emit(state.copyWith(status: AddMovieStatus.success));
  }

  void updateMovie(Movie movie) {
    final state = this.state;
    emit(state.copyWith(status: AddMovieStatus.success));
    final movieIndex = _listMovie.indexWhere(
      (movieIndex) {
        return movie.id == movieIndex.id;
      },
    );
    _listMovie.replaceRange(movieIndex, movieIndex + 1, [movie]);
    emit(state.copyWith(status: AddMovieStatus.success));
  }
}
