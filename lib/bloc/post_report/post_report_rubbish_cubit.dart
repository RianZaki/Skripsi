import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:recything_mobile/bloc/post_report/post_report_rubbish_state.dart';
import 'package:recything_mobile/repositories/report_repo.dart';

class PostReportRubbishCubit extends Cubit<PostReportRubbishState> {
  PostReportRubbishCubit() : super(PostReportRubbishInitial());

  bool isCheckedKering = false;
  bool isCheckedBasah = false;

  void toggleCheckboxKering(bool value) {
    isCheckedKering = value;
  }

  void toggleCheckboxBasah(bool value) {
    isCheckedBasah = value;
  }

  String getTrashType() {
    if (isCheckedKering) {
      return 'Sampah Kering';
    } else if (isCheckedBasah) {
      return 'Sampah Basah';
    } else {
      return '';
    }
  }

  void reports(
      {BuildContext? context,
      required String reportType,
      required String location,
      required String longitude,
      required String latitude,
      required String addressPoint,
      required String trashType,
      required String desc,
      required List<File> images}) async {
    try {
      emit(PostReportRubbishLoading());
      await ReportRepo().addReport(
          context: context!,
          reportType: reportType,
          location: location,
          longitude: longitude,
          latitude: latitude,
          addressPoint: addressPoint,
          trashType: trashType,
          desc: desc,
          images: images);
      emit(PostReportRubbishSuccess());
    } catch (e) {
      emit(PostReportRubbishFailed(message: e.toString()));
    }
  }
}
