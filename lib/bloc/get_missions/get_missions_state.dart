part of 'get_missions_cubit.dart';

sealed class GetMissionsState extends Equatable {
  const GetMissionsState();

  @override
  List<Object> get props => [];
}

final class GetMissionsInitial extends GetMissionsState {}

final class GetMissionsLoading extends GetMissionsState {}

final class GetMissionsLoaded extends GetMissionsState {
  final GetMissionsModel missions;

  const GetMissionsLoaded({required this.missions});

  @override
  List<Object> get props => [missions];
}

final class GetMissionsFailed extends GetMissionsState {}
