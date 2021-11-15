import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutternews/helper/news.dart';
import 'package:flutternews/models/app_state.dart';
import 'package:flutternews/models/articleModel.dart';
import 'package:flutternews/redux/actions/news_actions.dart';

import 'home.dart';

class CategoryNews extends StatefulWidget {
  final String? category;
  CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = <ArticleModel>[]; //TODO: change this to redux
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // getCategoryNews();
  }

  // getCategoryNews() async {
  //   CategoryNewsClass newsClass = CategoryNewsClass();
  //   await newsClass.getNews(widget.category!);
  //   articles = newsClass.news;
  //   setState(() {
  //     _loading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        onInit: (store) {
          store.dispatch(
            getCategoryArticlesAction(widget.category!),
          );
        },
        converter: (store) => store.state,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              backgroundColor: Colors.transparent,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Boring',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'News',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              actions: [
                Opacity(
                  opacity: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Icon(Icons.save),
                  ),
                ),
              ],
              centerTitle: true,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    //filtered blogs
                    Container(
                      padding: const EdgeInsets.only(
                        top: 16,
                      ),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics:
                              const ClampingScrollPhysics(), //Allows listview.builder to scroll
                          itemCount: state.categoryNews.length,
                          itemBuilder: (context, index) {
                            return BlogTile(
                              imageUrl: state.categoryNews[index].urlToImage,
                              title: state.categoryNews[index].title,
                              desc: state.categoryNews[index].description,
                              url: state.categoryNews[index].url,
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
