import 'package:bloc/bloc.dart';
import 'package:recything_mobile/bloc/get_community_by_id/community_by_id_state.dart';
import 'package:recything_mobile/repositories/community_repo.dart';

class CommunityByIdCubit extends Cubit<CommunityByIdState> {
  CommunityByIdCubit() : super(CommunityByIdInitial());

  Future<void> getCommunityById({required String id}) async {
    try {
      emit(CommunityByIdLoading());
      final response = await CommunityRepo().getCommunityById(id: id);
      emit(CommunityByIdSuccess(response));
    } catch (e) {
      emit(CommunityByIdError(e.toString()));
    }
  }
}
