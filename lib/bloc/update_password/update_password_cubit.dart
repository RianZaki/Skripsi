import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recything_mobile/repositories/update_password_repo.dart';

part 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  UpdatePasswordCubit() : super(UpdatePasswordInitial());
  final _updatePasswordRepo = UpdatePasswordRepo();

  void resetState() {
    emit(UpdatePasswordInitial());
  }

  void updatePassword(
      {required String password,
      required String newPassword,
      required String confirmPassword}) async {
    emit(UpdatePasswordLoading());

    if (password == newPassword &&
        password.isNotEmpty &&
        newPassword.isNotEmpty) {
      emit(UpdatePasswordIdentical(errorMsg: 'Kata sandi baru harus berbeda'));
    } else {
      try {
        await _updatePasswordRepo.updatePassword(
            password: password,
            newPassword: newPassword,
            confirmPassword: confirmPassword);
        emit(UpdatePasswordSuccess());
      } catch (e) {
        emit(UpdatePasswordFailed(errorMsg: e.toString()));
        throw Exception(e);
      }
    }
  }
}
