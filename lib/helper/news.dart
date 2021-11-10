import 'dart:convert';

import '../models/articleModel.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=gb&apiKey=a920ad97e9fc4e84933b96be2f3a1ad3');
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    var list = jsonData['articles'] as List;
    print(list.runtimeType);
    List<ArticleModel> articlesList =
        list.map((e) => ArticleModel.fromJson(e)).toList();
    news = (articlesList);

    // if (jsonData['status'] == 'ok') {
    //   jsonData['articles'].forEach((element) {
    //     //check if img or description is missing
    //     if (element['urlToImage'] != null && element['description'] != null) {
    //       ArticleModel articleModel = ArticleModel(
    //         title: element['title'],
    //         author: element['author'],
    //         description: element['description'],
    //         url: element['url'],
    //         urlToImage: element['urlToImage'],
    //         content: element['content'],
    //       );

    //       news.add(articleModel);
    //     }
    //   });
    // }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];
  Future<void> getNews(String category) async {
    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?category=$category&country=gb&apiKey=a920ad97e9fc4e84933b96be2f3a1ad3');
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    var list = jsonData['articles'] as List;
    print(list.runtimeType);
    List<ArticleModel> articlesList =
        list.map((e) => ArticleModel.fromJson(e)).toList();
    news = (articlesList);
  }

  // if (jsonData['status'] == 'ok') {
  //   jsonData['articles'].forEach((element) {
  //     //check if img or description is missing
  //     if (element['urlToImage'] != null && element['description'] != null) {
  //       final ArticleModel articleModel = ArticleModel(
  //         title: element['title'],
  //         author: element['author'],
  //         description: element['description'],
  //         url: element['url'],
  //         urlToImage: element['urlToImage'],
  //         content: element['content'],
  //       );

  //       news.add(articleModel);
  //     }
  //   });
  // }
}
