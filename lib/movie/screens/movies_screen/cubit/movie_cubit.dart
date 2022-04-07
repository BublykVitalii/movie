import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/domain/movie_service.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(const MovieState());
  MovieService get moviesService => GetIt.instance.get<MovieService>();

  void getNowPlaying(int page) async {
    if (page == 1) {
      emit(state.copyWith(status: MovieStatus.loading));
    }
    try {
      final nowPlaying = await moviesService.getNowPlaying(page);

      emit(state.copyWith(
        status: MovieStatus.success,
        movies: List.of(state.movies)..addAll(nowPlaying!),
        hasReachedMax: false,
        page: page,
      ));
    } catch (e) {
      emit(state.copyWith(status: MovieStatus.error));
    }
  }

  void getNextPage() {
    var nextPage = state.page + 1;
    getNowPlaying(nextPage);
  }
}


// MovieCubit() : super(MovieInitial());
//   MovieService get moviesService => GetIt.instance.get<MovieService>();

//   int page = 1;
//   List<Movie> listMovie = [];

//   void getNowPlaying(int page) async {
//     if (page == 1) {
//       emit(MovieLoading());
//     }

//     try {
//       final nowPlaying = await moviesService.getNowPlaying(page);
//       listMovie.addAll(nowPlaying!);
//       emit(MovieSuccess(movies: listMovie));
//     } catch (e) {
//       emit(MovieError());
//     }
//   }

//   void getNextPage() {
//     var nextPage = page + 1;
//     page = nextPage;
//     getNowPlaying(nextPage);
//   }