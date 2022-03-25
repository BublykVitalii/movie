import 'package:injectable/injectable.dart';
import 'package:movie/movie/domain/movie.repository.dart';

import 'movie.dart';

@singleton
class MovieService {
  MovieService(this._movieRepository);

  final MovieRepository _movieRepository;

  List<Movie>? _movies;
  List<Movie>? get movie => _movies;

  Future<List<Movie>?> getNowPlaying() async {
    _movies = await _movieRepository.getNowPlaying();
    return _movies;
  }
}
