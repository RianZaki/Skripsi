part of 'get_history_poin_cubit.dart';

sealed class GetHistoryPoinState extends Equatable {
  const GetHistoryPoinState();

  @override
  List<Object> get props => [];
}

final class GetHistoryPoinInitial extends GetHistoryPoinState {}

final class GetHistoryPoinLoading extends GetHistoryPoinState {}

final class GetHistoryPoinSuccess extends GetHistoryPoinState {
  final List<HistoryPoinModel> data;

  GetHistoryPoinSuccess({required this.data});
}

final class GetHistoryPoinFailure extends GetHistoryPoinState {
  final String msg;

  GetHistoryPoinFailure({required this.msg});
}
