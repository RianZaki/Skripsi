part of 'get_popular_article_cubit.dart';

@immutable
sealed class GetPopularArticleState extends Equatable {
  const GetPopularArticleState();

  @override
  List<Object> get props => [];
}

final class GetPopularArticleInitial extends GetPopularArticleState {}

final class GetPopularArticleLoading extends GetPopularArticleState {}

final class GetPopularArticleSuccess extends GetPopularArticleState {
  final List<ArticleModel> data;

  const GetPopularArticleSuccess({required this.data});
}

final class GetPopularArticleFailure extends GetPopularArticleState {
  final String message;

  const GetPopularArticleFailure({required this.message});
}
