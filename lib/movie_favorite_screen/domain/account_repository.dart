abstract class AccountRepository {
  Future<void> getAccountId();
  Future<void> getFavorite(int movieId);
  Future<void> getListFavorite();
}
