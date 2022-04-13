import 'package:injectable/injectable.dart';
import 'package:movie/auth/api/dto/auth_token_dto.dart';
import 'package:movie/auth/domain/auth_repository.dart';
import 'package:movie/auth/domain/user.dart';

@singleton
class AuthService {
  AuthService(this._authRepository);
  final AuthRepository _authRepository;

  Future<AuthTokenDTO> getToken() async {
    final response = await _authRepository.getToken();
    return response;
  }

  Future<void> postSession() async {
    final response = await _authRepository.postSession();
  }

  Future<void> postSessionWithLogin(User user) async {
    final response = await _authRepository.postSessionWithLogin(user);
  }
}
