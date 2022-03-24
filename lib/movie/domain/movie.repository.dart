import 'movie.dart';

abstract class MovieRepository {
  Future<Movie> getMovieNowPlaying();
}
