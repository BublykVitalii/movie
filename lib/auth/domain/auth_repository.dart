abstract class AuthRepository {
  Future<void> sessionWithLogin(String username, String password);
}
