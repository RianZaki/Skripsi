import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:recything_mobile/constants/constans.dart';
import 'package:recything_mobile/services/shared_pref_service.dart';

class ClaimMissionRepo {
  Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> getMissions({required String missionId}) async {
    final token = await SharedPreferenceService.getToken();

    try {
      Options options = Options(headers: {'Authorization': 'Bearer $token'});

      final res = await dio.post("missions",
          data: {"mission_id": missionId}, options: options);

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
