import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recything_mobile/models/report_model.dart';
import 'package:recything_mobile/repositories/report_repo.dart';

part 'get_report_history_state.dart';

class GetReportHistoryCubit extends Cubit<GetReportHistoryState> {
  GetReportHistoryCubit() : super(GetReportHistoryInitial());
  final _repo = ReportRepo();

  void fetchReportHistory(BuildContext? context) async {
    emit(GetReportHistoryLoading());
    try {
      final data = await _repo.getReportHistory(context!);
      emit(GetReportHistorySuccess(data: data));
    } catch (e) {
      emit(GetReportHistoryFailure(message: e.toString()));
    }
  }
}
