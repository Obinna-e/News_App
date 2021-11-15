import 'articleModel.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final List<ArticleModel> articles;
  final List<ArticleModel> categoryNews;

  AppState({
    required this.articles,
    required this.categoryNews,
  });

  factory AppState.initial() {
    return AppState(
      articles: const [],
      categoryNews: const [],
    );
  }
}
