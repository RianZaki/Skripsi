part of 'claim_mission_cubit.dart';

sealed class ClaimMissionState extends Equatable {
  const ClaimMissionState();

  @override
  List<Object> get props => [];
}

final class ClaimMissionInitial extends ClaimMissionState {}

final class ClaimMissionLoading extends ClaimMissionState {}

final class ClaimMissionSuccess extends ClaimMissionState {}

final class ClaimMissionFailed extends ClaimMissionState {
  final String errorMsg;

  const ClaimMissionFailed({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
