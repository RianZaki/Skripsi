import 'package:equatable/equatable.dart';
import 'package:recything_mobile/models/community_model.dart';

sealed class CommunityByIdState extends Equatable {
  const CommunityByIdState();

  @override
  List<Object> get props => [];
}

class CommunityByIdInitial extends CommunityByIdState {}

class CommunityByIdLoading extends CommunityByIdState {}

class CommunityByIdError extends CommunityByIdState {
  final String errorMessage;

  const CommunityByIdError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class CommunityByIdSuccess extends CommunityByIdState {
  final CommunityModel community;

  const CommunityByIdSuccess(this.community);

  @override
  List<Object> get props => [community];
}
