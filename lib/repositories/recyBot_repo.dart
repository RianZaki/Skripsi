import 'package:dio/dio.dart';
import 'package:recything_mobile/constants/constans.dart';

import '../services/shared_pref_service.dart';

class RecyBotRepo {
  Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<String> postQuestion(String question) async {
    final String? authToken = await SharedPreferenceService.getToken();

    if (authToken == null) {
      throw Exception('Authorization token not available.');
    }

    dio.options.headers['Authorization'] = 'Bearer $authToken';
    final response = await dio.post(
      'recybot',
      data: {'question': question},
    );
    return response.data['data'];
  }
}
