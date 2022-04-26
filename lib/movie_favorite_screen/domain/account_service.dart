import 'package:injectable/injectable.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie_favorite_screen/domain/account_repository.dart';

@singleton
class AccountService {
  AccountService(this._accountRepository);
  final AccountRepository _accountRepository;

  Future<void> getAccountId() async {
    await _accountRepository.getAccountId();
  }

  Future<void> getFavorite(int movieId) async {
    await _accountRepository.getFavorite(movieId);
  }

  Future<List<Movie>> getListFavorite() async {
    return await _accountRepository.getListFavorite();
  }
}
