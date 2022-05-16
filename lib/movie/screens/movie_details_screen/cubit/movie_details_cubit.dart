import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/domain/movie_service.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final Movie movie;

  MovieDetailsCubit(this.movie) : super(MovieDetailsInitial(movie: movie));
  MovieService get moviesService => GetIt.instance.get<MovieService>();

  void getMovie() async {
    emit(MovieDetailsLoading(movie: movie));
    try {
      final movieDetails = await moviesService.getMovieById(movie.id!);

      emit(MovieDetailsSuccess(movie: movieDetails!));
    } catch (e) {
      emit(MovieDetailsError(movie: movie));
    }
  }
}
