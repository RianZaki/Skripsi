import 'package:bloc/bloc.dart';
import 'package:recything_mobile/bloc/forgot_password/forgot_password_state.dart';
import 'package:recything_mobile/repositories/forgot_password_repo.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInit());

  String email = "";
  String token = "";
  String getEmail() {
    return email;
  }

  Future<void> sendOTP({required String email}) async {
    try {
      emit(SendOTPLoading());
      await ForgotPasswordRepo().sendOTP(email: email);
      this.email = email;
      emit(SendOTPSuccess(email: email));
    } catch (e) {
      emit(SendOTPFailed(message: e.toString()));
    }
  }

  Future<void> verifyOTP({required String otp}) async {
    try {
      emit(VerifyOTPLoading());
      final response =
          await ForgotPasswordRepo().verifyOTP(email: email, otp: otp);
      token = response ?? "";
      emit(VerifyOTPSuccess(email: email));
    } catch (e) {
      emit(VerifyOTPFailed(message: e.toString()));
    }
  }

  Future<void> newPassword(
      {required String password, required String password2}) async {
    try {
      emit(NewPasswordLoading());
      await ForgotPasswordRepo()
          .newPassword(token: token, password: password, password2: password2);
      emit(NewPasswordSuccess(email: email));
    } catch (e) {
      emit(NewPasswordFailed(message: e.toString()));
    }
  }
}
