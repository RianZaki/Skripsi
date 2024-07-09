import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recything_mobile/repositories/history_poin_repo.dart';

part 'post_poin_daily_state.dart';

class PostPoinDailyCubit extends Cubit<PostPoinDailyState> {
  PostPoinDailyCubit() : super(PostPoinDailyInitial());
  final _repo = HistoryPoinRepo();

  void claimPoin({
    BuildContext? context,
  }) async {
    emit(PostPoinDailyLoading());
    try {
      final msg = await _repo.claimPoin(context!);
      emit(PostPoinDailySuccess(message: msg));
    } catch (e) {
      emit(PostPoinDailyFailure(message: e.toString()));
    }
  }
}
