import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recything_mobile/models/get_missions_model.dart';
import 'package:recything_mobile/repositories/get_missions_repo.dart';

part 'get_missions_state.dart';

class GetMissionsCubit extends Cubit<GetMissionsState> {
  GetMissionsCubit() : super(GetMissionsInitial());
  final _getMissionsRepo = GetMissionsRepo();
  GetMissionsModel? missionsData;

  void getMissions({String? filter}) async {
    emit(GetMissionsLoading());

    try {
      if (filter == 'berjalan') {
        missionsData = await _getMissionsRepo.getMissions(filter: 'berjalan');
      } else if (filter == 'selesai') {
        missionsData = await _getMissionsRepo.getMissions(filter: 'selesai');
      } else {
        missionsData = await _getMissionsRepo.getMissions();
      }

      emit(GetMissionsLoaded(
          missions: missionsData ??
              GetMissionsModel(status: false, message: 'message', data: [])));
    } catch (e) {
      emit(GetMissionsFailed());
    }
  }
}
