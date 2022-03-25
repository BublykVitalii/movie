import 'movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getNowPlaying();
}
