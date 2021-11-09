import 'package:flutter/material.dart';
import 'package:flutternews/models/article_model.dart';

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
