import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterInit extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailed extends RegisterState {
  final String message;

  RegisterFailed({required this.message});
}
