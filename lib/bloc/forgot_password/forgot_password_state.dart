import 'package:equatable/equatable.dart';

class ForgotPasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ForgotPasswordInit extends ForgotPasswordState {}

class SendOTPLoading extends ForgotPasswordState {}

class SendOTPSuccess extends ForgotPasswordState {
  final String email;
  SendOTPSuccess({required this.email});
  @override
  List<Object?> get props => [email];
}

class SendOTPFailed extends ForgotPasswordState {
  final String message;
  SendOTPFailed({required this.message});
  @override
  List<Object?> get props => [message];
}

// VERIFY OTP

class VerifyOTPLoading extends ForgotPasswordState {}

class VerifyOTPSuccess extends ForgotPasswordState {
  final String email;
  VerifyOTPSuccess({required this.email});

  @override
  List<Object?> get props => [email];
}

class VerifyOTPFailed extends ForgotPasswordState {
  final String message;

  VerifyOTPFailed({required this.message});
  @override
  List<Object?> get props => [message];
}

// NEW PASSWORD
class NewPasswordLoading extends ForgotPasswordState {}

class NewPasswordSuccess extends ForgotPasswordState {
  final String email;
  NewPasswordSuccess({required this.email});
  @override
  List<Object?> get props => [email];
}

class NewPasswordFailed extends ForgotPasswordState {
  final String message;
  NewPasswordFailed({required this.message});
  @override
  List<Object?> get props => [message];
}
