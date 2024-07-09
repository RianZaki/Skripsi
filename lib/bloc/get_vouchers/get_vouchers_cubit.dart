import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recything_mobile/models/get_vouchers_model.dart';
import 'package:recything_mobile/repositories/get_vouchers.dart';

part 'get_vouchers_state.dart';

class GetVouchersCubit extends Cubit<GetVouchersState> {
  GetVouchersCubit() : super(GetVouchersInitial());

  final _getVouchersRepo = GetVouchersRepo();
  int page = 1;

  void getVouchers() {
    if (state is GetVouchersLoading) return;

    final currentState = state;

    var oldPosts = <GetVouchersModel>[];
    if (currentState is GetVouchersLoaded) {
      oldPosts = currentState.vouchers;
    }

    emit(GetVouchersLoading(oldPosts, isFirstFetch: page == 1));

    _getVouchersRepo.getVouchers(page: page.toString()).then((newVouchersData) {
      page++;

      final vouchers = (state as GetVouchersLoading).oldVouchersData;
      vouchers!.addAll(newVouchersData);

      emit(GetVouchersLoaded(vouchers: vouchers));
    });
  }
}
