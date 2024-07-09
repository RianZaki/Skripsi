import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recything_mobile/models/events_model.dart';
import 'package:recything_mobile/repositories/events_repo.dart';

part 'get_all_event_state.dart';

class GetAllEventCubit extends Cubit<GetAllEventState> {
  GetAllEventCubit() : super(GetAllEventInitial());
  final _repo = EventRepo();

  void fetchData({BuildContext? context, required String id}) async {
    emit(GetAllEventLoading());
    try {
      final data = await _repo.getAllEvent(context: context, id: id);
      emit(GetAllEventSuccess(data: data));
    } catch (e) {
      emit(GetAllEventFailure(msg: e.toString()));
    }
  }
}
