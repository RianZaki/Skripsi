import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recything_mobile/models/report_model.dart';
import 'package:recything_mobile/repositories/report_repo.dart';

part 'get_history_report_by_id_state.dart';

class GetHistoryReportByIdCubit extends Cubit<GetHistoryReportByIdState> {
  GetHistoryReportByIdCubit() : super(GetHistoryReportByIdInitial());
  final _repo = ReportRepo();

  void fetchReportById({BuildContext? context, required String id}) async {
    emit(GetHistoryReportByIdLoading());
    try {
      final data = await _repo.getReportHistoryById(context, id: id);
      emit(GetHistoryReportByIdSuccess(data: data));
    } catch (e) {
      emit(GetHistoryReportByIdFailure(message: e.toString()));
    }
  }
}
