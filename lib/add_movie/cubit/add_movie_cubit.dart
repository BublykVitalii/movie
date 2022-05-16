import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/infrastructure/movie_image.dart';
import 'package:movie/movie/domain/movie.dart';

part 'add_movie_state.dart';

class AddMovieCubit extends Cubit<AddMovieState> {
  AddMovieCubit() : super(const AddMovieState());

  void createMovie(String title, String overview) {
    final movie = Movie(
      posterPath: MovieImage.posterImage,
      id: 0,
      title: title,
      overview: overview,
    );
    emit(state.copyWith(
      movie: movie,
      status: AddMovieStatus.success,
    ));
  }
}
