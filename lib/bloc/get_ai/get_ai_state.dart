part of 'get_ai_cubit.dart';

sealed class GetAiState extends Equatable {
  const GetAiState();

  @override
  List<Object> get props => [];
}

final class GetAiInitial extends GetAiState {}

final class GetAiLoading extends GetAiState {}

final class GetAiSuccess extends GetAiState {
  final String data;

  const GetAiSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

final class GetAiFailure extends GetAiState {
  final String msg;

  const GetAiFailure({required this.msg});

  @override
  List<Object> get props => [msg];
}
