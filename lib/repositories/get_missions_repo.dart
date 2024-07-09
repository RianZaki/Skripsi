import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:recything_mobile/constants/constans.dart';
import 'package:recything_mobile/models/get_missions_model.dart';
import 'package:recything_mobile/services/shared_pref_service.dart';

class GetMissionsRepo {
  Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<GetMissionsModel> getMissions({String? filter}) async {
    final token = await SharedPreferenceService.getToken();
    Response res;

    try {
      Options options = Options(headers: {'Authorization': 'Bearer $token'});

      if (filter == 'berjalan') {
        res = await dio.get("missions?filter=berjalan", options: options);
      } else if (filter == 'selesai') {
        res = await dio.get("missions?filter=selesai", options: options);
      } else {
        res = await dio.get("missions", options: options);
      }

      Logger().i(res.data);
      if (res.data['message'] == 'Belum ada misi') {
        return GetMissionsModel(status: false, message: 'false', data: []);
      }
      return GetMissionsModel.fromJson(res.data);
    } on DioException catch (e) {
      Logger().e(e.response);
      throw Exception(e);
    }
  }
}
