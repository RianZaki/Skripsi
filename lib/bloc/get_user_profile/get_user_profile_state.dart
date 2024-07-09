part of 'get_user_profile_cubit.dart';

sealed class GetUserProfileState extends Equatable {
  const GetUserProfileState();

  @override
  List<Object> get props => [];
}

final class GetUserProfileInitial extends GetUserProfileState {}

final class GetUserProfileLoading extends GetUserProfileState {}

final class GetUserProfileSuccess extends GetUserProfileState {
  final UserModel data;

  const GetUserProfileSuccess({required this.data});
}

final class GetUserProfilefailure extends GetUserProfileState {
  final String message;

  const GetUserProfilefailure({required this.message});
}
