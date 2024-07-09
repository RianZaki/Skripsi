part of 'community_cubit.dart';

sealed class CommunityState extends Equatable {
  const CommunityState();

  @override
  List<Object> get props => [];
}

class CommunityInitial extends CommunityState {}

class CommunityLoading extends CommunityState {}

class CommunityError extends CommunityState {
  final String errorMessage;

  const CommunityError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class CommunitySuccess extends CommunityState {
  final List<CommunityModel> communities;

  const CommunitySuccess(this.communities);

  @override
  List<Object> get props => [communities];
}
