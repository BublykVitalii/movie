import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie/domain/movie.dart';

part 'add_movie_state.dart';

class AddMovieCubit extends Cubit<AddMovieState> {
  AddMovieCubit() : super(const AddMovieState());

  void saveTitleDescription(String title, String overview) {
    final movie = Movie(
      title: title,
      overview: overview,
    );
    emit(state.copyWith(
      movie: movie,
      status: AddMovieStatus.success,
    ));
  }
}
