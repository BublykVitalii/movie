import 'package:injectable/injectable.dart';
import 'package:movie/movie/domain/movie.repository.dart';

import 'movie.dart';

enum MoviesCategory {
  nowPlaying,
  popular,
  topRated,
  upcoming,
}

@singleton
class MovieService {
  MovieService(this._movieRepository);

  final MovieRepository _movieRepository;

  List<Movie>? _movies;
  List<Movie>? get movies => _movies;

  Movie? _movie;
  Movie? get movie => _movie;

  Future<List<Movie>?> getNowPlaying(int page) async {
    _movies = await _movieRepository.getNowPlaying(page);
    return _movies;
  }

  Future<Movie?> getMovieById(int id) async {
    _movie = await _movieRepository.getMovieById(id);
    return _movie;
  }

  Future<List<Movie>?> getPopular(int page) async {
    _movies = await _movieRepository.getPopular(page);
    return _movies;
  }

  Future<List<Movie>?> getTopRated(int page) async {
    _movies = await _movieRepository.getTopRated(page);
    return _movies;
  }

  Future<List<Movie>?> getUpcoming(int page) async {
    _movies = await _movieRepository.getUpcoming(page);
    return _movies;
  }

  static String movieCategory(MoviesCategory type) {
    switch (type) {
      case MoviesCategory.nowPlaying:
        return 'Movie';
      case MoviesCategory.popular:
        return 'Popular';
      case MoviesCategory.topRated:
        return 'Top Rated';
      case MoviesCategory.upcoming:
        return 'Upcoming';
      default:
        return 'Movie';
    }
  }

  String movieCategoryToString(MoviesCategory type) => movieCategory(type);
}
