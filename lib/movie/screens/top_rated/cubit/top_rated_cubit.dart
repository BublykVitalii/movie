import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/domain/movie_exceptions.dart';
import 'package:movie/movie/domain/movie_service.dart';

part 'top_rated_state.dart';

class TopRatedCubit extends Cubit<TopRatedState> {
  TopRatedCubit() : super(const TopRatedState());
  MovieService get moviesService => GetIt.instance.get<MovieService>();

  Future<void> getTopRated() async {
    emit(state.copyWith(status: TopRatedStatus.loading));
    try {
      final topRated = await moviesService.getTopRated(state.page);
      final movies = List.of(state.movies)..addAll(topRated!);
      emit(state.copyWith(
        status: TopRatedStatus.success,
        movies: movies,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TopRatedStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> loadMoreTopRatedMovies() async {
    if (state.status == TopRatedStatus.loadMore) return;
    emit(state.copyWith(status: TopRatedStatus.loadMore));
    try {
      final nextPage = state.page + 1;
      final topRated = await moviesService.getTopRated(nextPage);
      final movies = List.of(state.movies)..addAll(topRated!);
      emit(state.copyWith(
        status: TopRatedStatus.success,
        movies: movies,
        page: nextPage,
      ));
    } on NoResultsExceptions catch (error) {
      emit(state.copyWith(
        status: TopRatedStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
