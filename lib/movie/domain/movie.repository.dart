import 'movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getNowPlaying(int page);
  Future<Movie> getMovieById(int id);
  Future<List<Movie>> getPopular(int page);
  Future<List<Movie>> getTopRated(int page);
  Future<List<Movie>> getUpcoming(int page);
}
