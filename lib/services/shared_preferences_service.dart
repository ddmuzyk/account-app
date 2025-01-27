import 'package:dsw_52745/constants.dart' as constants;
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  late final SharedPreferences prefs;

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<String> getLoggedUser() async {
    return prefs.getString(constants.userNameKey) ?? '';
  }

  Future<void> setLoggedUser(String userName) async {
    await prefs.setString(constants.userNameKey, userName);
  }

  Future<void> clearUser() async {
    await prefs.remove(constants.userNameKey);
  }
}
