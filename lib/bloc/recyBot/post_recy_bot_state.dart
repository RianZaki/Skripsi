part of 'post_recy_bot_cubit.dart';

sealed class PostRecyBotState {
  const PostRecyBotState();

  // @override
  List<Object> get props => [];
}

final class PostRecyBotInitial extends PostRecyBotState {}

final class PostRecyBotLoading extends PostRecyBotState {}

final class PostRecyBotSuccess extends PostRecyBotState {
  final String answer;

  const PostRecyBotSuccess({required this.answer});

  @override
  List<Object> get props => [answer];
}

final class PostRecyBotFailure extends PostRecyBotState {
  final String msg;

  const PostRecyBotFailure({required this.msg});

  @override
  List<Object> get props => [msg];
}
