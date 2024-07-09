import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:recything_mobile/constants/constans.dart';

class RegisterRepo {
  Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> register({
    required String fullname,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final data = {
        "fullname": fullname,
        "email": email,
        "password": password,
        "confirm_password": confirmPassword,
      };
      Logger().i(data);

      final response = await dio.post(
        "register",
        data: data,
      );

      Map<String, dynamic> responseData = json.decode(response.toString());
      Logger().i(responseData);
      // final loginModel = LoginModel.fromJson(responseData);

      // final pref = await SharedPreferences.getInstance();
      // pref.setString('token', loginModel.data.token);
    } on DioException catch (e) {
      Logger().e(e.response);
      if (e.response != null) {
        final response = jsonDecode(e.response.toString());
        throw response["message"];
      }
    }
  }
}
