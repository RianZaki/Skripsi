import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:recything_mobile/constants/constans.dart';
import 'package:recything_mobile/services/shared_pref_service.dart';

class UpdatePasswordRepo {
  Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> updatePassword(
      {required String password,
      required String newPassword,
      required String confirmPassword}) async {
    final token = await SharedPreferenceService.getToken();

    try {
      Options options = Options(headers: {'Authorization': 'Bearer $token'});

      final data = {
        "password": password,
        "new_password": newPassword,
        "confirm_password": confirmPassword
      };
      Logger().i(data);

      final res = await dio.patch("users/profile/reset-password",
          data: data, options: options);

      Logger().i(res.data);
    } on DioException catch (e) {
      Logger().e(e.response);
      if (e.response != null) {
        final response = jsonDecode(e.response.toString());
        throw response["message"];
      }
    }
  }
}
