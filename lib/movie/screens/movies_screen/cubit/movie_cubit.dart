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
      final category = await _movieListCategory(state.page);
      emit(state.copyWith(
        status: MovieStatus.success,
        movies: category,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: MovieStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<List<Movie>?> _movieListCategory(int page) async {
    switch (_typeMovies) {
      case MoviesCategory.nowPlaying:
        return moviesService.getNowPlaying(page);
      case MoviesCategory.popular:
        return moviesService.getPopular(page);
      case MoviesCategory.topRated:
        return moviesService.getTopRated(page);
      case MoviesCategory.upcoming:
        return moviesService.getUpcoming(page);
      default:
        return moviesService.getNowPlaying(page);
    }
  }

  Future<void> loadMoreMoviesList() async {
    if (state.status == MovieStatus.loadMore) return;
    emit(state.copyWith(status: MovieStatus.loadMore));
    try {
      final nextPage = state.page + 1;
      final type = await _movieList(nextPage);
      final movies = List.of(state.movies)..addAll(type!);
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

  MoviesCategory _typeMovies = MoviesCategory.nowPlaying;
  MoviesCategory type(MoviesCategory type) => _typeMovies = type;

  Future<List<Movie>?> _movieList(int page) async {
    switch (_typeMovies) {
      case MoviesCategory.nowPlaying:
        return moviesService.getNowPlaying(page);
      case MoviesCategory.popular:
        return moviesService.getPopular(page);
      case MoviesCategory.topRated:
        return moviesService.getTopRated(page);
      case MoviesCategory.upcoming:
        return moviesService.getUpcoming(page);
      default:
        return moviesService.getNowPlaying(page);
    }
  }

  String movieCategoryToString(MoviesCategory type) =>
      moviesService.movieCategory(type);
}
