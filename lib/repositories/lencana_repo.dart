import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:recything_mobile/models/lencana_model.dart';
import 'package:recything_mobile/services/base_service.dart';

class LencanaRepo extends BaseService {
  Future<List<LencanaModel>> getLencana(BuildContext context) async {
    final res = await request(context, '/achievements');
    Logger().i(res);
    return List<LencanaModel>.from(
        (res.data["data"] as Iterable).map((e) => LencanaModel.fromJson(e)));
  }
}
