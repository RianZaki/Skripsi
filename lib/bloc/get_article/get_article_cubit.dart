import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:recything_mobile/models/article_model.dart';
import 'package:recything_mobile/repositories/article_repo.dart';
part 'get_article_state.dart';

class GetArticleCubit extends Cubit<GetArticleState> {
  // ArticleModel? detailArtikel = ArticleModel();

  GetArticleCubit() : super(GetArticleInitial());

  // void clearDdetailArtikel() {
  //   detailArtikel = null;
  // }

  void getAllArticle() async {
    emit(GetArticleLoading());
    try {
      final response = await ArticleRepo().getAllArticle();
      emit(GetArticleSuccess(data: response));
    } catch (e) {
      emit(GetArticleFailure(message: e.toString()));
    }
  }

  void searchArticle(String data) async {
    emit(GetArticleLoading());
    try {
      final response = await ArticleRepo().searchArticle(data);
      if (response.isEmpty) {
        emit(GetArticleFailure(message: "data not found"));
      } else {
        emit(GetArticleSuccess(data: response));
      }
    } catch (e) {
      emit(GetArticleFailure(message: e.toString()));
    }
  }

  void searchArticleByCategory(String filter, String data) async {
    emit(GetArticleLoading());
    try {
      final response =
          await ArticleRepo().searchArticleByCategory(filter, data);
      if (response.isEmpty) {
        emit(GetArticleFailure(message: "data not found"));
      } else {
        emit(GetArticleSuccess(data: response));
      }
    } catch (e) {
      emit(GetArticleFailure(message: e.toString()));
    }
  }

  void getArticleByCategory(String filter) async {
    emit(GetArticleLoading());
    try {
      final response = await ArticleRepo().getArticleByCategory(filter);
      if (response.isEmpty) {
        emit(GetArticleFailure(message: "data not found"));
      } else {
        emit(GetArticleSuccess(data: response));
      }
    } catch (e) {
      emit(GetArticleFailure(message: e.toString()));
    }
  }

  // int countLike(int like) {
  //   like = like + 1;
  //   print("halooo ${like}");
  //   return like;
  // }

  void getArticleById(String id) async {
    emit(GetArticleLoading());
    try {
      final response = await ArticleRepo().getArticleById(id);
      emit(GetArticleByIdSuccess(data: response));
    } catch (e) {
      print(e);
      emit(GetArticleFailure(message: e.toString()));
    }
  }

  void postLikeArticle(String id) async {
    emit(GetArticleLoading());
    try {
      final response = await ArticleRepo().postLikeArticle(id);
      emit(PostLikeArticleSuccess(message: response));
    } catch (e) {
      emit(GetArticleFailure(message: e.toString()));
    }
  }
}
