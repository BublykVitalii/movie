import 'package:movie/movie/domain/movie.dart';

abstract class FavoriteMovieRepository {
  Future<void> markAsFavorite(int movieId);
  Future<List<Movie>> getListFavorite();
}
