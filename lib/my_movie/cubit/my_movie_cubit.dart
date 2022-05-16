import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/infrastructure/movie_image.dart';
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

  void updateMovieList(Movie movie) {
    List<Movie> listMovie = state.listMovie ?? [];
    emit(state.copyWith(
      status: MyMovieStatus.loading,
      listMovie: listMovie,
    ));
    final newMovie = Movie(
      posterPath: MovieImage.posterImage,
      title: movie.title,
      overview: movie.overview,
      id: listMovie.length,
    );
    listMovie.add(newMovie);

    emit(state.copyWith(
      status: MyMovieStatus.success,
      listMovie: listMovie,
      movie: newMovie,
    ));
  }
}
