import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recything_mobile/models/history_poin_model.dart';
import 'package:recything_mobile/repositories/history_poin_repo.dart';

part 'get_history_poin_by_id_state.dart';

class GetHistoryPoinByIdCubit extends Cubit<GetHistoryPoinByIdState> {
  GetHistoryPoinByIdCubit() : super(GetHistoryPoinByIdInitial());
  final _repo = HistoryPoinRepo();

  void fetchData({BuildContext? context, required String id}) async {
    emit(GetHistoryPoinByIdLoading());
    try {
      final data = await _repo.getHistoryById(context: context, id: id);
      emit(GetHistoryPoinByIdSuccess(data: data));
    } catch (e) {
      emit(GetHistoryPoinByIdFailure(msg: e.toString()));
    }
  }
}
