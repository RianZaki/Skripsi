import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:recything_mobile/constants/constans.dart';
import 'package:recything_mobile/services/shared_pref_service.dart';

class UploadProofRepo {
  Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> uploadProof(
      {required String missionId,
      required String description,
      required List<XFile> images}) async {
    final token = await SharedPreferenceService.getToken();

    try {
      Options options = Options(headers: {'Authorization': 'Bearer $token'});

      List<MultipartFile> imageFiles = [];

      for (var i = 0; i < images.length; i++) {
        XFile imageFile = images[i];
        String fileName = imageFile.path.split('/').last;

        imageFiles.add(
          await MultipartFile.fromFile(
            imageFile.path,
            filename: fileName,
          ),
        );
      }

      FormData formData = FormData.fromMap({
        'mission_id': missionId,
        'description': description,
        'images': imageFiles.map((file) => MapEntry('images[]', file)).toList(),
      });

      // Logger().i(imageFiles[0].filename);

      final res =
          await dio.post("missions/proof", data: formData, options: options);

      Logger().i(res.data);
    } on DioException catch (e) {
      Logger().e(e.response);
      if (e.response != null) {
        final response = jsonDecode(e.response.toString());
        throw response["message"];
      }
    }
  }

  Future<String> updateProof(
      {required String description,
      required List<XFile> images,
      required String transactionId}) async {
    final token = await SharedPreferenceService.getToken();

    try {
      Options options = Options(headers: {'Authorization': 'Bearer $token'});

      List<MultipartFile> imageFiles = [];

      for (var i = 0; i < images.length; i++) {
        XFile imageFile = images[i];
        String fileName = imageFile.path.split('/').last;

        imageFiles.add(
          await MultipartFile.fromFile(
            imageFile.path,
            filename: fileName,
          ),
        );
      }

      FormData formData = FormData.fromMap({
        'description': description,
        'images': imageFiles.map((file) => MapEntry('images[]', file)).toList(),
      });

      final res = await dio.put("missions/proof/$transactionId",
          data: formData, options: options);

      Logger().i(res.data);
      return res.data['message'];
    } on DioException catch (e) {
      Logger().e(e.response);
      if (e.response != null) {
        final response = jsonDecode(e.response.toString());
        throw response["message"];
      }
    }

    return '';
  }
}
