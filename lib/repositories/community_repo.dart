import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:recything_mobile/constants/constans.dart';
import 'package:recything_mobile/models/community_model.dart';
import 'package:recything_mobile/services/shared_pref_service.dart';

class CommunityRepo {
  Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<List<CommunityModel>> getCommunity({String? search}) async {
    final token = await SharedPreferenceService.getToken();

    try {
      Options options = Options(headers: {'Authorization': 'Bearer $token'});

      final res = await dio.get(
          "communities${search != null ? "?search=$search" : ""}",
          options: options);

      Logger().i(res.data);

      return res.data['message'] == 'data belum tersedia'
          ? List.empty()
          : List<CommunityModel>.from((res.data['data'] as Iterable)
              .map((e) => CommunityModel.fromJson(e)));
    } on DioException catch (e) {
      Logger().e(e.response);
      throw Exception(e);
    }
  }

  Future<CommunityModel> getCommunityById({required String id}) async {
    final token = await SharedPreferenceService.getToken();

    try {
      Options options = Options(headers: {'Authorization': 'Bearer $token'});

      final res = await dio.get("communities/${id}", options: options);

      Logger().i(res.data);

      return CommunityModel.fromJson(res.data['data']);
    } on DioException catch (e) {
      Logger().e(e.response);
      throw Exception(e);
    }
  }

  Future<String> joinCommunity({required String id}) async {
    final token = await SharedPreferenceService.getToken();

    try {
      Options options = Options(headers: {'Authorization': 'Bearer $token'});

      final res = await dio.post("communities/${id}", options: options);

      Logger().i(res.data);

      return res.data['message'];
    } on DioException catch (e) {
      Logger().e(e.response);
      throw Exception(e);
    }
  }
}
