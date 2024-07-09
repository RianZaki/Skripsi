import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/article_model.dart';
import '../../repositories/article_repo.dart';

part 'get_popular_article_state.dart';

class GetPopularArticleCubit extends Cubit<GetPopularArticleState> {
  GetPopularArticleCubit() : super(GetPopularArticleInitial());

  void getPopularArticle() async {
    emit(GetPopularArticleLoading());
    try {
      final response = await ArticleRepo().getPopularArticle();
      if (response.isEmpty) {
        emit(GetPopularArticleFailure(message: "Rekomendasi artikel belum tersedia."));
      }
      emit(GetPopularArticleSuccess(data: response));
    } catch (e) {
      emit(GetPopularArticleFailure(message: e.toString()));
    }
  }
}
