part of 'get_poin_daily_cubit.dart';

sealed class GetPoinDailyState extends Equatable {
  const GetPoinDailyState();

  @override
  List<Object> get props => [];
}

final class GetPoinDailyInitial extends GetPoinDailyState {}

final class GetPoinDailyLoading extends GetPoinDailyState {}

final class GetPoinDailySuccess extends GetPoinDailyState {
  final List<DailyPoinModel> data;

  GetPoinDailySuccess({required this.data});
}

final class GetPoinDailyFailure extends GetPoinDailyState {
  final String msg;

  GetPoinDailyFailure({required this.msg});
}
