import 'package:flutternews/models/article_Model.dart';
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
