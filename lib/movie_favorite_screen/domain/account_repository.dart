import 'package:movie/movie/domain/movie.dart';

abstract class AccountRepository {
  Future<void> getAccountId();
  Future<void> getFavorite(int movieId);
  Future<List<Movie>> getListFavorite();
}
