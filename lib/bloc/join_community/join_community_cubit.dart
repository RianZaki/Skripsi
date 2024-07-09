import 'package:bloc/bloc.dart';
import 'package:recything_mobile/bloc/join_community/join_community_state.dart';
import 'package:recything_mobile/repositories/community_repo.dart';

class JoinCommunityCubit extends Cubit<JoinCommunityState> {
  JoinCommunityCubit() : super(JoinCommunityInitial());

  Future<void> joinCommunity({required String id}) async {
    try {
      emit(JoinCommunityLoading());
      await CommunityRepo().joinCommunity(id: id);
      emit(JoinCommunitySuccess());
    } catch (e) {
      emit(JoinCommunityError(e.toString()));
    }
  }
}
