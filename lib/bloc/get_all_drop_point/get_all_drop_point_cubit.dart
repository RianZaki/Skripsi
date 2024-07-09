import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recything_mobile/models/drop_points_model.dart';
import 'package:recything_mobile/repositories/drop_points_repo.dart';

part 'get_all_drop_point_state.dart';

class GetAllDropPointCubit extends Cubit<GetAllDropPointState> {
  GetAllDropPointCubit() : super(GetAllDropPointInitial());
  final _repo = DropPointsRepo();
  int currentPage = 1;
  List<DropPointsModel> allData = [];

  void fetchData({
    BuildContext? context,
    int? page,
    String? search,
  }) async {
    emit(GetAllDropPointLoading());
    try {
      final data = await _repo.getDropPoints(
        context: context,
        page: page,
        search: search,
      );
      currentPage = page ?? 1;
      allData = data.data!;
      emit(GetAllDropPointSuccess(
        data: allData,
      ));
    } catch (e) {
      emit(GetAllDropPointFailure(msg: e.toString()));
    }
  }
}