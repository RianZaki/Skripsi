import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:recything_mobile/constants/constans.dart';

class ForgotPasswordRepo {
  Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> sendOTP({required String email}) async {
    try {
      final data = {
        "email": email,
      };
      Logger().i(data);

      final response = await dio.post(
        "forgot-password",
        data: data,
      );

      Map<String, dynamic> responseData = json.decode(response.toString());
      Logger().i(responseData);
    } on DioException catch (e) {
      if (e.response != null) {
        final response = jsonDecode(e.response.toString());
        throw response["message"];
      }
    }
  }

  Future<String?> verifyOTP(
      {required String email, required String otp}) async {
    try {
      final data = {
        "email": email,
        "otp": otp,
      };
      Logger().i(data);

      final response = await dio.post(
        "verify-otp",
        data: data,
      );

      Map<String, dynamic> responseData = json.decode(response.toString());
      Logger().i(responseData);

      return responseData["data"];
    } on DioException catch (e) {
      Logger().e(e.response);
      if (e.response != null) {
        final response = jsonDecode(e.response.toString());
        throw response["message"];
      }
    }
    return null;
  }

  Future<void> newPassword({
    required String token,
    required String password,
    required String password2,
  }) async {
    try {
      final data = {
        "password": password,
        "confirm_password": password2,
      };
      Logger().i(data);

      final response = await dio.patch(
        "new-password",
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
        data: data,
      );

      Map<String, dynamic> responseData = json.decode(response.toString());
      Logger().i(responseData);
    } on DioException catch (e) {
      Logger().e(e.response);
      if (e.response != null) {
        final response = jsonDecode(e.response.toString());
        throw response["message"];
      }
    }
  }
}
