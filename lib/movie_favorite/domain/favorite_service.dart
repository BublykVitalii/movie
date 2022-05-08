import 'package:injectable/injectable.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie_favorite/domain/favorite_movie_repository.dart';

@singleton
class FavoriteService {
  FavoriteService(this._favoriteMovieRepository);
  final FavoriteMovieRepository _favoriteMovieRepository;

  Future<void> markAsFavorite(int movieId) async {
    await _favoriteMovieRepository.markAsFavorite(movieId);
  }

  Future<List<Movie>> getListFavorite() async {
    return await _favoriteMovieRepository.getListFavorite();
  }
}
