import 'dart:convert';
import 'package:recything_mobile/constants/constans.dart';
import 'package:recything_mobile/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static Future<void> saveUser(DataLogin user) async {
    final pref = await SharedPreferences.getInstance();

    pref.setString(userKey, json.encode(user));
  }

  static Future<DataLogin?> getUser() async {
    final pref = await SharedPreferences.getInstance();

    final res = pref.getString(userKey);
    DataLogin? user;
    if (res != null) {
      user = DataLogin.fromJson(json.decode(res));
    }

    return user;
  }

  static Future<bool> hasToken() async {
    final user = await getUser();

    return user?.token != null;
  }

  static Future<String?> getToken() async {
    final user = await getUser();

    return user?.token;
  }

  static Future<void> deleteUser() async {
    final pref = await SharedPreferences.getInstance();

    await pref.remove(userKey);
  }
}
