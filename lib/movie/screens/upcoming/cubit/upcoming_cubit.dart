import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/domain/movie_exceptions.dart';
import 'package:movie/movie/domain/movie_service.dart';

part 'upcoming_state.dart';

class UpcomingCubit extends Cubit<UpcomingState> {
  UpcomingCubit() : super(const UpcomingState());
  MovieService get moviesService => GetIt.instance.get<MovieService>();

  Future<void> getUpcoming() async {
    emit(state.copyWith(status: UpcomingStatus.loading));
    try {
      final upcoming = await moviesService.getUpcoming(state.page);
      final movies = List.of(state.movies)..addAll(upcoming!);
      emit(state.copyWith(
        status: UpcomingStatus.success,
        movies: movies,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: UpcomingStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> loadMoreUpcomingMovies() async {
    if (state.status == UpcomingStatus.loadMore) return;
    emit(state.copyWith(status: UpcomingStatus.loadMore));
    try {
      final nextPage = state.page + 1;
      final upcoming = await moviesService.getUpcoming(nextPage);
      final movies = List.of(state.movies)..addAll(upcoming!);
      emit(state.copyWith(
        status: UpcomingStatus.success,
        movies: movies,
        page: nextPage,
      ));
    } on NoResultsExceptions catch (error) {
      emit(state.copyWith(
        status: UpcomingStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
