import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:recything_mobile/models/report_model.dart';
import 'package:recything_mobile/services/base_service.dart';

class ReportLitteringRepo extends BaseService {
  Future<List<ReportModel>> getReportHistory(BuildContext context) async {
    final res = await request(context, 'reports/history');
    // Logger().e(res);
    return List<ReportModel>.from(
      (res.data['data'] as Iterable).map((e) => ReportModel.fromJson(e)),
    );
  }

  Future<ReportModel> getReportHistoryById(param0,
      {BuildContext? context, required String id}) async {
    final res = await request(context, 'reports/history/$id');
    Logger().e(res);
    return ReportModel.fromJson(res.data["data"]);
  }

  // Future<void> addReport({
  //   required String reportType,
  //   required String location,
  //   required num longitude,
  //   required num latitude,
  //   required String addressPoint,
  //   required String trashType,
  //   required String desc,
  //   required List<XFile> images,
  // }) async {
  //   try {
  //     List<MultipartFile> imageFiles = [];

  //     for (var image in images) {
  //       List<int> imageBytes = await image.readAsBytes();
  //       String imageName = DateTime.now().toString();
  //       MultipartFile file = MultipartFile.fromBytes(
  //         imageBytes,
  //         filename: imageName,
  //       );
  //       imageFiles.add(file);
  //     }
  //     final data = {
  //       "report_type": reportType,
  //       "location": location,
  //       "longitude": longitude,
  //       "latitude": latitude,
  //       "address_point": addressPoint,
  //       "trash_type": trashType,
  //       "description": desc,
  //       "images": imageFiles,
  //     };

  //     FormData formData = FormData.fromMap(data);
  //     Logger().i(data);

  //     final response = await dio.post(
  //       "/reports",
  //       data: data,
  //       options: Options(
  //         headers: {
  //           'Content-Type': 'multipart/form-data',
  //         },
  //       ),
  //     );

  //     Map<String, dynamic> responseData = json.decode(response.toString());
  //     Logger().i(responseData);
  //   } on DioException catch (e) {
  //     Logger().e(e.response);
  //     if (e.response != null) {
  //       final response = jsonDecode(e.response.toString());
  //       throw response["message"];
  //     } else {
  //       throw "An unexpected error occured";
  //     }
  //   }
  // }
  Future<String> addReport({
    required BuildContext context,
    required String reportType,
    String? scaleType,
    bool? dangerousWaste,
    String? insidentDate,
    String? insidentTime,
    String? companyName,
    required String location,
    required String longitude,
    required String latitude,
    required String addressPoint,
    String? trashType,
    required String desc,
    required List<File> images,
  }) async {
    try {
      List<MultipartFile> files = await Future.wait(images.map((e) async {
        String fileName = e.path.split('/').last;
        return MultipartFile.fromFile(e.path, filename: fileName);
      }));
      // Logger().i(files);

      FormData formData = await FormData.fromMap({
        "report_type": reportType,
        "scale_type": scaleType,
        "location": location,
        "longitude": longitude,
        "latitude": latitude,
        "address_point": addressPoint,
        "company_name": companyName,
        "insident_date": insidentDate,
        "insident_time": insidentTime,
        "trash_type": trashType,
        "description": desc,
        "dangerous_waste": dangerousWaste,
        "images": files,
      });
      // Logger().i(latitude);
      // Logger().i(longitude);

      final response = await request(
        context,
        "reports",
        requestType: RequestType.post,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      Logger().e(response);

      return "message";
    } on DioException catch (e) {
      Logger().e(e.response);
      if (e.response != null) {
        final response = jsonDecode(e.response.toString());
        throw response["message"];
      }
      return "error";
    }
  }
}
