import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/domain/movie_service.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieInitial());
  MovieService get movies => GetIt.instance.get<MovieService>();

  void getNowPlaying(int number) async {
    emit(MovieLoading());
    try {
      final nowPlaying = await movies.getNowPlaying();
      emit(MovieSuccess(movies: nowPlaying));
    } catch (e) {
      emit(MovieError());
    }
  }
}
