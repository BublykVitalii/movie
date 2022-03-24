import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/domain/movie_service.dart';
import 'package:movie/movie/screens/cubit/movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieInitial());
  MovieService get movies => GetIt.instance.get<MovieService>();

  void getMovieNowPlaying(int number) async {
    emit(MovieLoading());
    try {
      final Movie? nowPlaying = await movies.getMovieNowPlaying();
      emit(MovieSuccess(movie: nowPlaying));
      print(nowPlaying);
    } catch (e) {
      emit(MovieError());
    }
  }
}
