abstract class AuthRepository {
  Future<void> postSessionWithLogin(String username, String password);
}
