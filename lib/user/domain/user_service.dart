import 'package:injectable/injectable.dart';
import 'package:movie/user/domain/user_repository.dart';

@singleton
class UserService {
  UserService(this._userRepository);
  final UserRepository _userRepository;

  Future<void> getAccountId() async {
    await _userRepository.getAccountId();
  }
}
