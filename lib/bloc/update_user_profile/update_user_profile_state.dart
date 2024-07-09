part of 'update_user_profile_cubit.dart';

sealed class UpdateUserProfileState extends Equatable {
  const UpdateUserProfileState();

  @override
  List<Object> get props => [];
}

final class UpdateUserProfileInitial extends UpdateUserProfileState {}

final class UpdateUserProfileLoading extends UpdateUserProfileState {}

final class UpdateUserProfileSuccess extends UpdateUserProfileState {
  final String data;

  const UpdateUserProfileSuccess({required this.data});
}

final class UpdateUserProfileFailure extends UpdateUserProfileState {
  final String message;

  const UpdateUserProfileFailure({required this.message});
}
