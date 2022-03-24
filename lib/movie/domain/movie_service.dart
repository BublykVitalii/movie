import 'package:injectable/injectable.dart';
import 'package:movie/movie/domain/movie.repository.dart';

import 'movie.dart';

@singleton
class MovieService {
  MovieService(this._movieRepository);

  final MovieRepository _movieRepository;

  Movie? _movie;
  Movie? get movie => _movie;

  Future<Movie?> getMovieNowPlaying() async {
    _movie = await _movieRepository.getMovieNowPlaying();
    return _movie;
  }
}
