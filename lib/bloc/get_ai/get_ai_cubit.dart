import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recything_mobile/repositories/ai_repo.dart';

part 'get_ai_state.dart';

class GetAiCubit extends Cubit<GetAiState> {
  GetAiCubit() : super(GetAiInitial());

  void fetchAi(String text) async {
    emit(GetAiLoading());
    try {
      final data = await getAi(text);
      emit(GetAiSuccess(data: data));
    } catch (e) {
      emit(GetAiFailure(msg: e.toString()));
    }
  }
}
