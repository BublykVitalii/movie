import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/domain/movie_exceptions.dart';
import 'package:movie/movie/domain/movie_service.dart';

part 'popular_state.dart';

class TopRatedCubit extends Cubit<PopularState> {
  TopRatedCubit() : super(const PopularState());
  MovieService get moviesService => GetIt.instance.get<MovieService>();

  Future<void> getPopular() async {
    emit(state.copyWith(status: PopularStatus.loading));
    try {
      final popular = await moviesService.getPopular(state.page);
      final movies = List.of(state.movies)..addAll(popular!);
      emit(state.copyWith(
        status: PopularStatus.success,
        movies: movies,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PopularStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> loadMorePopularMovies() async {
    if (state.status == PopularStatus.loadMore) return;
    emit(state.copyWith(status: PopularStatus.loadMore));
    try {
      final nextPage = state.page + 1;
      final popular = await moviesService.getPopular(nextPage);
      final movies = List.of(state.movies)..addAll(popular!);
      emit(state.copyWith(
        status: PopularStatus.success,
        movies: movies,
        page: nextPage,
      ));
    } on NoResultsExceptions catch (error) {
      emit(state.copyWith(
        status: PopularStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
