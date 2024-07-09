import 'package:equatable/equatable.dart';

sealed class JoinCommunityState extends Equatable {
  const JoinCommunityState();

  @override
  List<Object> get props => [];
}

class JoinCommunityInitial extends JoinCommunityState {}

class JoinCommunityLoading extends JoinCommunityState {}

class JoinCommunityError extends JoinCommunityState {
  final String errorMessage;

  const JoinCommunityError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class JoinCommunitySuccess extends JoinCommunityState {}
