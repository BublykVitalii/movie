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

  Future<void> getPopular() async {
    emit(state.copyWith(status: MovieStatus.loading));
    try {
      final popular = await moviesService.getPopular(state.page);

      emit(state.copyWith(
        status: MovieStatus.success,
        movies: popular,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: MovieStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> loadMorePopularMovies() async {
    if (state.status == MovieStatus.loadMore) return;
    emit(state.copyWith(status: MovieStatus.loadMore));
    try {
      final nextPage = state.page + 1;
      final popular = await moviesService.getPopular(nextPage);
      final movies = List.of(state.movies)..addAll(popular!);
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

  Future<void> getTopRated() async {
    emit(state.copyWith(status: MovieStatus.loading));
    try {
      final topRated = await moviesService.getTopRated(state.page);

      emit(state.copyWith(
        status: MovieStatus.success,
        movies: topRated,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: MovieStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> loadMoreTopRatedMovies() async {
    if (state.status == MovieStatus.loadMore) return;
    emit(state.copyWith(status: MovieStatus.loadMore));
    try {
      final nextPage = state.page + 1;
      final topRated = await moviesService.getTopRated(nextPage);
      final movies = List.of(state.movies)..addAll(topRated!);
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

  Future<void> getUpcoming() async {
    emit(state.copyWith(status: MovieStatus.loading));
    try {
      final upcoming = await moviesService.getUpcoming(state.page);

      emit(state.copyWith(
        status: MovieStatus.success,
        movies: upcoming,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: MovieStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> loadMoreUpcomingMovies() async {
    if (state.status == MovieStatus.loadMore) return;
    emit(state.copyWith(status: MovieStatus.loadMore));
    try {
      final nextPage = state.page + 1;
      final upcoming = await moviesService.getUpcoming(nextPage);
      final movies = List.of(state.movies)..addAll(upcoming!);
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

  String _typeMovies = 'Movie';

  String type(String type) => _typeMovies = type;

  Future<void> loadMore() async {
    switch (_typeMovies) {
      case 'Movie':
        loadMoreMovies();
        break;
      case 'Popular':
        loadMorePopularMovies();
        break;
      case 'Top rated':
        loadMoreTopRatedMovies();
        break;
      case 'Upcoming':
        loadMoreUpcomingMovies();
        break;
    }
  }
}
