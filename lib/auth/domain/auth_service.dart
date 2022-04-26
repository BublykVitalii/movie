import 'package:injectable/injectable.dart';
import 'package:movie/auth/domain/auth_repository.dart';

@singleton
class AuthService {
  AuthService(this._authRepository);
  final AuthRepository _authRepository;

  Future<void> sessionWithLogin(String username, String password) async {
    await _authRepository.sessionWithLogin(username, password);
  }

  Future<bool> inLoggedIn() async {
    return await _authRepository.inLoggedIn();
  }

  Future<void> logOut() async {
    await _authRepository.logOut();
  }
}
