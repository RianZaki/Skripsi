import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../repositories/article_repo.dart';

part 'post_like_article_state.dart';

class PostLikeArticleCubit extends Cubit<PostLikeArticleState> {
  bool isLike = false;
  PostLikeArticleCubit() : super(PostLikeArticleInitial());

  void postLikeArticle(String id) async {
    emit(PostLikeLoading());
    try {
      final response = await ArticleRepo().postLikeArticle(id);
      if (response == "berhasil melakukan like") {
        isLike = true;
        emit(PostLikeSuccess(message: response, isLike: isLike));
      } 
      
      // else if (response == "berhasil unlike artikel") {
      //   isLike = false;
      //   emit(PostLikeSuccess(message: response, isLike: isLike));
      // }
    } catch (e) {
      isLike = false;
      emit(PostLikeFailure(message: e.toString(), isLike: isLike));
    }
  }
}
