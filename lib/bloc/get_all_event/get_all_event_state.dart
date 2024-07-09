part of 'get_all_event_cubit.dart';

sealed class GetAllEventState extends Equatable {
  const GetAllEventState();

  @override
  List<Object> get props => [];
}

final class GetAllEventInitial extends GetAllEventState {}

final class GetAllEventLoading extends GetAllEventState {}

final class GetAllEventSuccess extends GetAllEventState {
  final List<EventsModel> data;

  GetAllEventSuccess({required this.data});
}

final class GetAllEventFailure extends GetAllEventState {
  final String msg;

  GetAllEventFailure({required this.msg});
}
