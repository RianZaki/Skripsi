import 'package:bloc/bloc.dart';
import 'package:recything_mobile/bloc/register/register_state.dart';
import 'package:recything_mobile/repositories/register_repo.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInit());

  void register({
    required String fullname,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      emit(RegisterLoading());
      await RegisterRepo().register(
        fullname: fullname,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailed(message: e.toString()));
    }
  }
}
