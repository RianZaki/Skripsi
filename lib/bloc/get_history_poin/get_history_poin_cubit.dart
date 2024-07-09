import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recything_mobile/models/history_poin_model.dart';
import 'package:recything_mobile/repositories/history_poin_repo.dart';

part 'get_history_poin_state.dart';

class GetHistoryPoinCubit extends Cubit<GetHistoryPoinState> {
  GetHistoryPoinCubit() : super(GetHistoryPoinInitial());

  final _repo = HistoryPoinRepo();

  void fetchHistoryPoin(BuildContext? context) async {
    emit(GetHistoryPoinLoading());
    try {
      final data = await _repo.getHistoryPoin(context!);
      emit(GetHistoryPoinSuccess(data: data));
    } catch (e) {
      emit(GetHistoryPoinFailure(msg: e.toString()));
    }
  }
}
