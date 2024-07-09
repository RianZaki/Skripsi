part of 'update_password_cubit.dart';

sealed class UpdatePasswordState extends Equatable {
  const UpdatePasswordState();

  @override
  List<Object> get props => [];
}

final class UpdatePasswordInitial extends UpdatePasswordState {}

final class UpdatePasswordLoading extends UpdatePasswordState {}

final class UpdatePasswordSuccess extends UpdatePasswordState {}

final class UpdatePasswordIdentical extends UpdatePasswordState {
  final String errorMsg;

  const UpdatePasswordIdentical({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

final class UpdatePasswordFailed extends UpdatePasswordState {
  final String errorMsg;

  const UpdatePasswordFailed({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
