import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/domain/movie_service.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit(MovieDetailsState initialState) : super(initialState);
  MovieService get moviesService => GetIt.instance.get<MovieService>();

  void getMovie(int id) async {
    emit(MovieDetailsLoading());
    try {
      final movie = await moviesService.getMovieById(id);
      emit(MovieDetailsSuccess(movie: movie));
    } catch (e) {
      emit(MovieDetailsError());
    }
  }
}
