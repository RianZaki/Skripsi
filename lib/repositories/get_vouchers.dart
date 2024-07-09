import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:recything_mobile/constants/constans.dart';
import 'package:recything_mobile/models/get_vouchers_model.dart';
import 'package:recything_mobile/services/base_service.dart';
import 'package:recything_mobile/services/shared_pref_service.dart';

class GetVouchersRepo {
  Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<List<GetVouchersModel>> getVouchers({required String page}) async {
    final token = await SharedPreferenceService.getToken();

    try {
      Options options = Options(headers: {'Authorization': 'Bearer $token'});

      final res = await dio.get("vouchers?page=$page", options: options);

      Logger().i(res.data);

      return res.data['message'] == 'data belum tersedia'
          ? List.empty()
          : List<GetVouchersModel>.from((res.data['data'] as Iterable)
              .map((e) => GetVouchersModel.fromJson(e)));
    } on DioException catch (e) {
      Logger().e(e.response);
      throw Exception(e);
    }
  }
}

class voucherRepo extends BaseService {
  Future<String> postVoucher(
      {required BuildContext context,
      required String id,
      required String phone}) async {
    final res = await request(context, '/vouchers',
        requestType: RequestType.post,
        data: {"id_voucher": id, "phone": phone});
    Logger().i(res);
    return res.data["message"];
  }
}
