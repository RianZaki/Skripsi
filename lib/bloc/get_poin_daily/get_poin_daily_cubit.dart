import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recything_mobile/models/daily_poin_model.dart';
import 'package:recything_mobile/repositories/history_poin_repo.dart';

part 'get_poin_daily_state.dart';

class GetPoinDailyCubit extends Cubit<GetPoinDailyState> {
  GetPoinDailyCubit() : super(GetPoinDailyInitial());
  final _repo = HistoryPoinRepo();
  void fetchDailyPoin(BuildContext? context) async {
    emit(GetPoinDailyLoading());
    try {
      final data = await _repo.getClaim(context!);
      emit(GetPoinDailySuccess(data: data));
    } catch (e) {
      emit(GetPoinDailyFailure(msg: e.toString()));
    }
  }
}
