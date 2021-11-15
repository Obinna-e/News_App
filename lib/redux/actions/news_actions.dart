import 'dart:convert';

import 'package:flutternews/models/app_state.dart';
import 'package:flutternews/models/articleModel.dart';

import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

// ignore: prefer_function_declarations_over_variables
ThunkAction<AppState> getArticlesAction = (Store<AppState> store) async {
  List<ArticleModel> articles = [];

  var url = Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=gb&apiKey=a920ad97e9fc4e84933b96be2f3a1ad3');
  var response = await http.get(url);
  var jsonData = jsonDecode(response.body);

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

// ignore: prefer_function_declarations_over_variables
ThunkAction<AppState> getCategoryArticlesAction(String category) {
  return (Store<AppState> store) async {
    List<ArticleModel> categoryArticles = [];

    // Future<void> getNews() async {
    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?category=$category&country=gb&apiKey=a920ad97e9fc4e84933b96be2f3a1ad3');
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
}

class GetCategoryArticlesAction {
  final List<ArticleModel> _categoryArticles;
  List<ArticleModel> get articles => this._categoryArticles;

  GetCategoryArticlesAction(this._categoryArticles);
}
