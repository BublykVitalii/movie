import 'movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getNowPlaying(int page);
  Future<Movie> getMovieById(int id);
}
