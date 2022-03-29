import 'package:injectable/injectable.dart';
import 'package:movie/movie/domain/movie.repository.dart';

import 'movie.dart';

@singleton
class MovieService {
  MovieService(this._movieRepository);

  final MovieRepository _movieRepository;

  List<Movie>? _movies;
  List<Movie>? get movies => _movies;

  Movie? _movie;
  Movie? get movie => _movie;

  Future<List<Movie>?> getNowPlaying() async {
    _movies = await _movieRepository.getNowPlaying();
    return _movies;
  }

  Future<Movie?> getMovieById(int id) async {
    _movie = await _movieRepository.getMovieById(id);
    return _movie;
  }
}
