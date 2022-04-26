import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class StoreInteraction {
  Future<void> setSessionId(String sessionId) async {
    final preference = await SharedPreferences.getInstance();
    await preference.setString('session_id', sessionId);
  }

  Future<String?> getSessionId() async {
    final preference = await SharedPreferences.getInstance();
    final String? sessionId = preference.getString('session_id');
    return sessionId;
  }

  Future<void> removeSessionId() async {
    final preference = await SharedPreferences.getInstance();
    await preference.remove('session_id');
  }

  Future<void> setAccountId(int accountId) async {
    final preference = await SharedPreferences.getInstance();
    await preference.setInt('account_id', accountId);
  }

  Future<int?> getAccountId() async {
    final preference = await SharedPreferences.getInstance();
    final int? accountId = preference.getInt('account_id');
    return accountId;
  }
}
