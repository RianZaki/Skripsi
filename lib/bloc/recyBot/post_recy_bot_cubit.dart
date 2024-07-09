import 'package:bloc/bloc.dart';
import '../../repositories/recyBot_repo.dart';
part 'post_recy_bot_state.dart';

class PostRecyBotCubit extends Cubit<PostRecyBotState> {
  final RecyBotRepo recyBotRepo = RecyBotRepo();
  List<Map<String, String>> QuestionAnswerList = [];

  PostRecyBotCubit() : super(PostRecyBotInitial());

  void clearQuestionAnswerList() {
    QuestionAnswerList.clear();
  }

  void getAnswer(String question) async {
    final answer = await recyBotRepo.postQuestion(question);
      QuestionAnswerList.add({
        "question": question,
        "answer": answer,
        "time":
            "${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}"
      });
  }

  void postQuestion(String question) async {
    emit(PostRecyBotLoading());
    try {
      final answer = await recyBotRepo.postQuestion(question);
      QuestionAnswerList.add({
        "question": question,
        "answer": answer,
        "time":
            "${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}"
      });
      emit(PostRecyBotSuccess(answer: answer));
    } catch (e) {
      emit(PostRecyBotFailure(msg: e.toString()));
    }
  }
}
