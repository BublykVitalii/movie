import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/domain/movie_exceptions.dart';
import 'package:movie/movie/domain/movie_service.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(const MovieState());
  MovieService get moviesService => GetIt.instance.get<MovieService>();

  Future<void> getMovies() async {
    emit(state.copyWith(status: MovieStatus.loading));
    try {
      final nowPlaying = await moviesService.getNowPlaying(state.page);
      final movies = List.of(state.movies)..addAll(nowPlaying!);
      emit(state.copyWith(
        status: MovieStatus.success,
        movies: movies,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: MovieStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> loadMoreMovies() async {
    if (state.status == MovieStatus.loadMore) return;
    emit(state.copyWith(status: MovieStatus.loadMore));
    try {
      final nextPage = state.page + 1;
      final nowPlaying = await moviesService.getNowPlaying(nextPage);
      final movies = List.of(state.movies)..addAll(nowPlaying!);
      emit(state.copyWith(
        status: MovieStatus.success,
        movies: movies,
        page: nextPage,
      ));
    } on NoResultsExceptions catch (error) {
      emit(state.copyWith(
        status: MovieStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
