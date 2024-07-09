part of 'post_voucher_cubit.dart';

sealed class PostVoucherState extends Equatable {
  const PostVoucherState();

  @override
  List<Object> get props => [];
}

final class PostVoucherInitial extends PostVoucherState {}

final class PostVoucherLoading extends PostVoucherState {}

final class PostVoucherSuccess extends PostVoucherState {
  final String message;

  PostVoucherSuccess({required this.message});
}

final class PostVoucherFailure extends PostVoucherState {
  final String message;

  PostVoucherFailure({required this.message});
}
