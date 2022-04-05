import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/domain/movie_service.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieInitial());
  MovieService get moviesService => GetIt.instance.get<MovieService>();

  int page = 1;
  List<Movie> listMovie = [];

  void getNowPlaying(int page) async {
    emit(MovieLoading());
    try {
      final nowPlaying = await moviesService.getNowPlaying(page);
      listMovie.addAll(nowPlaying!);
      // print(listMovie.length);
      // print(nowPlaying.length);
      emit(MovieSuccess(movies: listMovie));
    } catch (e) {
      emit(MovieError());
    }
  }

  void getNextPage() {
    var nextPage = page + 1;
    page = nextPage;
    getNowPlaying(nextPage);
  }
}
