part of 'get_all_faq_cubit.dart';

sealed class GetAllFaqState extends Equatable {
  const GetAllFaqState();

  @override
  List<Object> get props => [];
}

final class GetAllFaqInitial extends GetAllFaqState {}

final class GetAllFaqLoading extends GetAllFaqState {}

final class GetAllFaqSuccess extends GetAllFaqState {
  final List<FaqModel> data;

  const GetAllFaqSuccess({required this.data});
}

final class GetAllFaqFailure extends GetAllFaqState {
  final String message;

  const GetAllFaqFailure({required this.message});
}
