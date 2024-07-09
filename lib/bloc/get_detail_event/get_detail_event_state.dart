part of 'get_detail_event_cubit.dart';

sealed class GetDetailEventState extends Equatable {
  const GetDetailEventState();

  @override
  List<Object> get props => [];
}

final class GetDetailEventInitial extends GetDetailEventState {}

final class GetDetailEventLoading extends GetDetailEventState {}

final class GetDetailEventSuccess extends GetDetailEventState {
  final EventsModel data;

  GetDetailEventSuccess({required this.data});
}

final class GetDetailEventFailure extends GetDetailEventState {
  final String msg;

  GetDetailEventFailure({required this.msg});
}
