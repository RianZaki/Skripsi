import 'package:dio/dio.dart';
import 'package:recything_mobile/constants/constans.dart';
import 'package:recything_mobile/models/faq_model.dart';

final Dio _dio = Dio();

class FaqRepo {
  Future<List<FaqModel>> getAllFaq() async {
    final res = await _dio.get('$baseUrl/faq');
    return List<FaqModel>.from(
        (res.data['data'] as Iterable).map((e) => FaqModel.fromJson(e)));
  }
}
