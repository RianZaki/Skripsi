part of 'get_history_poin_by_id_cubit.dart';

sealed class GetHistoryPoinByIdState extends Equatable {
  const GetHistoryPoinByIdState();

  @override
  List<Object> get props => [];
}

final class GetHistoryPoinByIdInitial extends GetHistoryPoinByIdState {}

final class GetHistoryPoinByIdLoading extends GetHistoryPoinByIdState {}

final class GetHistoryPoinByIdSuccess extends GetHistoryPoinByIdState {
  final HistoryPoinModel data;

  GetHistoryPoinByIdSuccess({required this.data});
}

final class GetHistoryPoinByIdFailure extends GetHistoryPoinByIdState {
  final String msg;

  GetHistoryPoinByIdFailure({required this.msg});
}
