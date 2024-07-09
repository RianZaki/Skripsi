import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recything_mobile/bloc/login/login_state.dart';
import 'package:recything_mobile/repositories/login_repo.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInit());

  Future<void> login({required String email, required String password}) async {
    try {
      emit(LoginLoading());
      await LoginRepo().login(email: email, password: password);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailed(message: e.toString()));
    }
  }
}
