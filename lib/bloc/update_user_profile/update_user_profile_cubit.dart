import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recything_mobile/repositories/user_repo.dart';

part 'update_user_profile_state.dart';

class UpdateUserProfileCubit extends Cubit<UpdateUserProfileState> {
  UpdateUserProfileCubit() : super(UpdateUserProfileInitial());
  final _repo = UserRepo();

  void updateProfile(
      {BuildContext? context,
      required String fullname,
      String? address,
      String? date,
      String? purpose}) async {
    emit(UpdateUserProfileLoading());
    try {
      final msg = await _repo.updateUserProfile(
          context: context!,
          fullname: fullname,
          address: address,
          date: date,
          purpose: purpose);
      emit(UpdateUserProfileSuccess(data: msg));
    } catch (e) {
      emit(UpdateUserProfileFailure(message: e.toString()));
    }
  }
}
