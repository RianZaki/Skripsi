import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recything_mobile/repositories/claim_mission_repo.dart';
part 'claim_mission_state.dart';

class ClaimMissionCubit extends Cubit<ClaimMissionState> {
  ClaimMissionCubit() : super(ClaimMissionInitial());
  final _claimMissionRepo = ClaimMissionRepo();

  void claimMission({required String missionId}) async {
    emit(ClaimMissionLoading());
    try {
      await _claimMissionRepo.getMissions(missionId: missionId);
      emit(ClaimMissionSuccess());
    } catch (e) {
      emit(ClaimMissionFailed(errorMsg: e.toString()));
    }
  }
}
