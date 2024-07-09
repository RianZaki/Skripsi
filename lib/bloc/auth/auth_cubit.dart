import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recything_mobile/services/shared_pref_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void appStarted() async {
    try {
      bool hasToken = await SharedPreferenceService.hasToken();
      if (hasToken) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnAuthenticated());
      }
    } catch (e) {
      emit(AuthUnAuthenticated());
    }
  }

  void loggedIn() async {
    emit(AuthAuthenticated());
  }

  void loggedOut() async {
    await SharedPreferenceService.deleteUser();
    emit(AuthUnAuthenticated());
  }
}
