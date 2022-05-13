import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/add_movie/domain/movie.dart';
part 'my_movie_state.dart';

class MyMovieCubit extends Cubit<MyMovieState> {
  MyMovieCubit() : super(const MyMovieState());

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

  void getMovie() {
    emit(state.copyWith(
      status: MyMovieStatus.success,
      listMovie: _listMovie,
    ));
  }

  void data(String title, String description) {
    emit(state.copyWith(
      status: MyMovieStatus.loading,
      listMovie: _listMovie,
    ));
    final movie = Movie(
      title: title,
      description: description,
      id: listMovie.length,
    );
    _listMovie.add(movie);

    emit(state.copyWith(
      status: MyMovieStatus.success,
      listMovie: _listMovie,
    ));
  }
}
