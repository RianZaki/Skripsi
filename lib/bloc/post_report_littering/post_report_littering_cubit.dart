import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:recything_mobile/bloc/post_report_littering/post_report_littering_state.dart';
import 'package:recything_mobile/repositories/report_littering_repo.dart';

class PostReportLitteringCubit extends Cubit<PostReportLitteringState> {
  PostReportLitteringCubit() : super(PostReportLitteringInitial());

  bool isCheckedKering = false;
  bool isCheckedBasah = false;

  void toggleCheckboxKering() {
    isCheckedKering = !isCheckedKering;
    emit(PostReportLitteringCheckboxUpdated());
  }

  void toggleCheckboxBasah() {
    isCheckedBasah = !isCheckedBasah;
    emit(PostReportLitteringCheckboxUpdated());
  }

  void addReport({
    required BuildContext context,
    required String reportType,
    String? scaleType,
    String? companyName,
    bool? dangerousWaste,
    required String location,
    required String longitude,
    required String latitude,
    required String addressPoint,
    required String insidentDate,
    required String insidentTime,
    String? trashType,
    required String desc,
    required List<File> images,
  }) async {
    try {
      emit(PostReportLitteringLoading());
      await ReportLitteringRepo().addReport(
        context: context,
        reportType: reportType,
        scaleType: scaleType,
        companyName: companyName,
        location: location,
        longitude: longitude,
        latitude: latitude,
        addressPoint: addressPoint,
        trashType: trashType,
        insidentDate: insidentDate,
        insidentTime: insidentTime,
        desc: desc,
        dangerousWaste: dangerousWaste,
        images: images,
      );
      emit(PostReportLitteringSuccess());
    } catch (e) {
      Logger().e(e);
      emit(PostReportLitteringFailed(message: e.toString()));
    }
  }
}
