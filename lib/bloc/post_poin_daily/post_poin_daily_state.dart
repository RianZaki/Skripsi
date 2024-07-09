part of 'post_poin_daily_cubit.dart';

sealed class PostPoinDailyState extends Equatable {
  const PostPoinDailyState();

  @override
  List<Object> get props => [];
}

final class PostPoinDailyInitial extends PostPoinDailyState {}

final class PostPoinDailyLoading extends PostPoinDailyState {}

final class PostPoinDailySuccess extends PostPoinDailyState {
  final String message;

  PostPoinDailySuccess({required this.message});
}

final class PostPoinDailyFailure extends PostPoinDailyState {
  final String message;

  PostPoinDailyFailure({required this.message});
}
