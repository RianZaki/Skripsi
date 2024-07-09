import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:recything_mobile/constants/constans.dart';

import 'package:recything_mobile/models/login_model.dart';
import 'package:recything_mobile/services/shared_pref_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'package:logger/logger.dart';

class LoginRepo {
  Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> login({required String email, required String password}) async {
    try {
      final data = {
        "email": email,
        "password": password,
      };
      Logger().i(data);

      final response = await dio.post(
        "login",
        data: data,
      );

      Map<String, dynamic> responseData = json.decode(response.toString());
      final loginModel = LoginModel.fromJson(responseData);

      // final pref = await SharedPreferences.getInstance();
      // pref.setString('token', loginModel.data.token);
      await SharedPreferenceService.saveUser(loginModel.data);
    } on DioException catch (e) {
      // Logger().e(e.response);
      if (e.response != null) {
        final response = jsonDecode(e.response.toString());
        throw response["message"];
      }
    }
  }
}
