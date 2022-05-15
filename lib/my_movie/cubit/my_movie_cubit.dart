import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie/domain/movie.dart';

part 'my_movie_state.dart';

class MyMovieCubit extends Cubit<MyMovieState> {
  MyMovieCubit() : super(const MyMovieState());

  void getMovie() {
    emit(state.copyWith(
      status: MyMovieStatus.success,
      listMovie: state.listMovie,
    ));
  }

  void updateMovieList(String title, String description) {
    List<Movie> listMovie = state.listMovie ?? [];
    emit(state.copyWith(
      status: MyMovieStatus.loading,
      listMovie: listMovie,
    ));
    final movie = Movie(
      title: title,
      overview: description,
      id: listMovie.length,
    );
    listMovie.add(movie);

    emit(state.copyWith(
      status: MyMovieStatus.success,
      listMovie: listMovie,
    ));
  }
}
