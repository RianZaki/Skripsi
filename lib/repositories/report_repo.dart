import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:recything_mobile/models/report_model.dart';
import 'package:recything_mobile/services/base_service.dart';

class ReportRepo extends BaseService {
  Future<List<ReportModel>> getReportHistory(BuildContext context) async {
    final res = await request(context, 'reports/history');
    Logger().e(res);
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

  Future<String> addReport({
    required BuildContext context,
    required String reportType,
    required String location,
    required String longitude,
    required String latitude,
    required String addressPoint,
    required String trashType,
    required String desc,
    required List<File> images,
  }) async {
    try {
      List<MultipartFile> imageFiles = [];

      for (var image in images) {
        MultipartFile multipartFile = await MultipartFile.fromFile(
          image.path,
          filename: "image${images.indexOf(image)}.png",
        );
        imageFiles.add(multipartFile);
      }
      FormData formData = FormData.fromMap({
        "report_type": reportType,
        "location": location,
        "longitude": longitude,
        "latitude": latitude,
        "address_point": addressPoint,
        "trash_type": trashType,
        "description": desc,
        "images": imageFiles
      });
      Logger().e("""
        "report_type": $reportType,
        "location": $location,
        "longitude": $longitude,
        "latitude": $latitude,
        "address_point": $addressPoint,
        "trash_type": $trashType,
        "description": $desc,
        "images": $imageFiles
      """);

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
    } catch (error) {
      print("Error sending data: $error");
      return "error";
    }
  }
}
