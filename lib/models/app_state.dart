import 'articleModel.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final List<ArticleModel> articles;

  AppState({
    required this.articles,
  });

  factory AppState.initial() {
    return AppState(
      articles: [],
    );
  }
}
