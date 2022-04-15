import 'package:injectable/injectable.dart';
import 'package:movie/auth/domain/auth_repository.dart';

@singleton
class AuthService {
  AuthService(this._authRepository);
  final AuthRepository _authRepository;

  Future<void> postSessionWithLogin(String username, String password) async {
    await _authRepository.postSessionWithLogin(username, password);
  }
}
