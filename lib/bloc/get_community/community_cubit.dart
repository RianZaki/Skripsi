import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recything_mobile/models/community_model.dart';
import 'package:recything_mobile/repositories/community_repo.dart';

part 'community_state.dart';

class CommunityCubit extends Cubit<CommunityState> {
  CommunityCubit() : super(CommunityInitial());

  Future<void> getCommunity({String? search}) async {
    try {
      emit(CommunityLoading());
      final response = await CommunityRepo().getCommunity(search: search);
      emit(CommunitySuccess(response));
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }
}
