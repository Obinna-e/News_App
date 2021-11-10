import '../../models/app_state.dart';
import '../../models/article_Model.dart';
import '../actions/news_actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    articles: articlesReducer(state.articles, action),
  );
}

List<ArticleModel> articlesReducer(
    List<ArticleModel> articles, dynamic action) {
  if (action is GetArticlesAction) {
    return action.articles;
  }
  return articles;
}
