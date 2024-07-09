import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:recything_mobile/models/user_model.dart';
import 'package:recything_mobile/services/base_service.dart';

class UserRepo extends BaseService {
  Future<UserModel> getUserProfile(BuildContext context) async {
    final res = await request(context, 'users/profile');
    Logger().i(res);
    return UserModel.fromJson(res.data["data"]);
  }

  Future<String> updateUserProfile(
      {required BuildContext context,
      required String fullname,
      String? address,
      String? date,
      String? purpose}) async {
    final res = await request(context, 'users/profile',
        requestType: RequestType.update,
        data: {
          "fullname": fullname,
          "phone": "6282287653245",
          "address": address,
          "date_of_birth": date,
          "purpose": purpose
        });
    Logger().i(res);
    return res.data["message"];
  }
}
