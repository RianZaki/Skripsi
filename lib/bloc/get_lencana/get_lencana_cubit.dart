import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recything_mobile/models/lencana_model.dart';
import 'package:recything_mobile/repositories/lencana_repo.dart';

part 'get_lencana_state.dart';

class GetLencanaCubit extends Cubit<GetLencanaState> {
  GetLencanaCubit() : super(GetLencanaInitial());
  final _repo = LencanaRepo();

  void fetchLencana(BuildContext? context) async {
    emit(GetLencanaLoading());
    try {
      final data = await _repo.getLencana(context!);
      emit(GetLencanaSuccess(data: data));
    } catch (e) {
      emit(GetLencanaFailure(msg: e.toString()));
    }
  }
}
