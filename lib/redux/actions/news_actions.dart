import 'dart:convert';

import 'package:flutternews/models/app_state.dart';

import '../../models/article_Model.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> getArticlesAction = (Store<AppState> store) async {
  List<ArticleModel> articles = [];

  // Future<void> getNews() async {
  var url = Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=gb&apiKey=a920ad97e9fc4e84933b96be2f3a1ad3');
  var response = await http.get(url);
  var jsonData = jsonDecode(response.body);

  // var list = jsonData['articles'] as List;
  // print(list.runtimeType);
  // List<ArticleModel> articlesList =
  //     list.map((e) => ArticleModel.fromJson(e)).toList();
  // news = (articlesList);

  if (jsonData['status'] == 'ok') {
    jsonData['articles'].forEach((element) {
      //check if img or description is missing
      if (element['urlToImage'] != null && element['description'] != null) {
        ArticleModel articleModel = ArticleModel.fromJson(element);

        articles.add(articleModel);
      }
    });
  }

  store.dispatch(GetArticlesAction(articles));

  // }
};

class GetArticlesAction {
  final List<ArticleModel> _articles;
  List<ArticleModel> get articles => this._articles;

  GetArticlesAction(this._articles);
}

ThunkAction<AppState> getCategoryArticlesAction =
    (Store<AppState> store) async {
  List<ArticleModel> categoryArticles = [];

  // Future<void> getNews() async {
  var url = Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=gb&apiKey=a920ad97e9fc4e84933b96be2f3a1ad3');
  var response = await http.get(url);
  var jsonData = jsonDecode(response.body);

  if (jsonData['status'] == 'ok') {
    jsonData['articles'].forEach((element) {
      //check if img or description is missing
      if (element['urlToImage'] != null && element['description'] != null) {
        ArticleModel articleModel = ArticleModel.fromJson(element);

        categoryArticles.add(articleModel);
      }
    });
  }

  store.dispatch(GetCategoryArticlesAction(categoryArticles));

  // }
};

class GetCategoryArticlesAction {
  final List<ArticleModel> _categoryArticles;
  List<ArticleModel> get articles => this._categoryArticles;

  GetCategoryArticlesAction(this._categoryArticles);
}
