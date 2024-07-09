part of 'get_article_cubit.dart';

@immutable
sealed class GetArticleState extends Equatable {
  const GetArticleState();

  @override
  List<Object> get props => [];
}

final class GetArticleInitial extends GetArticleState {}

final class GetArticleLoading extends GetArticleState {}

final class GetArticleSuccess extends GetArticleState {
  final List<ArticleModel> data;

  const GetArticleSuccess({required this.data});
}

final class GetArticleByCategorySuccess extends GetArticleState {
  final List<ArticleModel> data;

  const GetArticleByCategorySuccess({required this.data});
}

final class GetArticleByIdSuccess extends GetArticleState {
  final ArticleModel data;

  const GetArticleByIdSuccess({required this.data});
}

final class SearchArticleByCategorySuccess extends GetArticleState {
  final List<ArticleModel> data;

  const SearchArticleByCategorySuccess({required this.data});
}

final class GetArticleFailure extends GetArticleState {
  final String message;

  const GetArticleFailure({required this.message});
}

final class PostLikeArticleSuccess extends GetArticleState {
  final String message;

  const PostLikeArticleSuccess({required this.message});
}
