part of 'get_vouchers_cubit.dart';

sealed class GetVouchersState extends Equatable {
  const GetVouchersState();

  @override
  List<Object> get props => [];
}

final class GetVouchersInitial extends GetVouchersState {}

final class GetVouchersLoading extends GetVouchersState {
  final List<GetVouchersModel>? oldVouchersData;
  final bool isFirstFetch;

  const GetVouchersLoading(this.oldVouchersData, {this.isFirstFetch = false});

  @override
  List<Object> get props => [oldVouchersData!, isFirstFetch];
}

final class GetVouchersLoaded extends GetVouchersState {
  final List<GetVouchersModel> vouchers;

  const GetVouchersLoaded({required this.vouchers});

  @override
  List<Object> get props => [vouchers];
}
