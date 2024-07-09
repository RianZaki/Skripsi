import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recything_mobile/repositories/get_vouchers.dart';

part 'post_voucher_state.dart';

class PostVoucherCubit extends Cubit<PostVoucherState> {
  PostVoucherCubit() : super(PostVoucherInitial());
  final _repo = voucherRepo();

  void postVoucher({
    BuildContext? context,
    required String id,
    required String phone,
  }) async {
    emit(PostVoucherLoading());
    try {
      final msg =
          await _repo.postVoucher(context: context!, id: id, phone: phone);
      emit(PostVoucherSuccess(message: msg));
    } catch (e) {
      emit(PostVoucherFailure(message: e.toString()));
    }
  }
}
