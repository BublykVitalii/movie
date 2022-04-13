import 'package:movie/auth/api/dto/auth_token_dto.dart';
import 'package:movie/auth/domain/user.dart';

abstract class AuthRepository {
  Future<AuthTokenDTO> getToken();
  Future<void> postSession();
  Future<void> postSessionWithLogin(User user);
}
