import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/domain/movie_service.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit()
      : super(const MovieState(
          movies: [],
        ));
  MovieService get moviesService => GetIt.instance.get<MovieService>();

  void getNowPlaying(int page) async {
    if (page == 1) {
      // emit(MovieSuccess(movies: listMovie));
      emit(state.copyWith(status: MovieStatus.loading));
    }
    List<Movie> listMovie = [];
    try {
      final nowPlaying = await moviesService.getNowPlaying(page);
      state.movies.addAll(nowPlaying!);

      emit(state.copyWith(
        status: MovieStatus.success,
        movies: listMovie,
        hasReachedMax: false,
      ));
    } catch (e) {
      emit(state.copyWith(status: MovieStatus.error));
    }
  }

  void getNextPage() {
    int page = 1;
    var nextPage = page + 1;
    page = nextPage;
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