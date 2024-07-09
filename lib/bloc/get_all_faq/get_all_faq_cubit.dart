import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recything_mobile/models/faq_model.dart';
import 'package:recything_mobile/repositories/faq_repo.dart';

part 'get_all_faq_state.dart';

class GetAllFaqCubit extends Cubit<GetAllFaqState> {
  GetAllFaqCubit() : super(GetAllFaqInitial());
  final _repo = FaqRepo();

  void fetchFaq() async {
    emit(GetAllFaqLoading());
    try {
      final data = await _repo.getAllFaq();
      emit(GetAllFaqSuccess(data: data));
    } catch (e) {
      emit(GetAllFaqFailure(message: e.toString()));
    }
  }
}
