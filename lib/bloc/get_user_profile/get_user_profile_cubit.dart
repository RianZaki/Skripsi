import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recything_mobile/models/user_model.dart';
import 'package:recything_mobile/repositories/user_repo.dart';

part 'get_user_profile_state.dart';

class GetUserProfileCubit extends Cubit<GetUserProfileState> {
  GetUserProfileCubit() : super(GetUserProfileInitial());
  final _repo = UserRepo();

  void fetchMe(BuildContext? context) async {
    emit(GetUserProfileLoading());
    try {
      final data = await _repo.getUserProfile(context!);
      emit(GetUserProfileSuccess(data: data));
    } catch (e) {
      emit(GetUserProfilefailure(message: e.toString()));
    }
  }
}
