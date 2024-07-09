import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recything_mobile/models/events_model.dart';
import 'package:recything_mobile/repositories/events_repo.dart';

part 'get_detail_event_state.dart';

class GetDetailEventCubit extends Cubit<GetDetailEventState> {
  GetDetailEventCubit() : super(GetDetailEventInitial());
  final _repo = EventRepo();
  void fetchData(
      {BuildContext? context,
      required String idKomunitas,
      required idEvent}) async {
    emit(GetDetailEventLoading());
    try {
      final data = await _repo.getDetailEvent(
          context: context, idKomunitas: idKomunitas, idEvent: idEvent);
      emit(GetDetailEventSuccess(data: data));
    } catch (e) {
      emit(GetDetailEventFailure(msg: e.toString()));
    }
  }
}
