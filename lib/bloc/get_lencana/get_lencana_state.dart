part of 'get_lencana_cubit.dart';

sealed class GetLencanaState extends Equatable {
  const GetLencanaState();

  @override
  List<Object> get props => [];
}

final class GetLencanaInitial extends GetLencanaState {}

final class GetLencanaLoading extends GetLencanaState {}

final class GetLencanaSuccess extends GetLencanaState {
  final List<LencanaModel> data;

  GetLencanaSuccess({required this.data});
}

final class GetLencanaFailure extends GetLencanaState {
  final String msg;

  GetLencanaFailure({required this.msg});
}
