import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutternews/helper/data.dart';
import 'package:flutternews/models/app_state.dart';
import 'package:flutternews/models/articleModel.dart';

import 'package:flutternews/models/category_model.dart';
import 'package:flutternews/redux/actions/news_actions.dart';
import 'package:flutternews/views/article_view.dart';
import 'package:flutternews/views/category_news.dart';
import '../helper/news.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];
  // bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories(); //should probs be redux side
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Boring',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'News',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        elevation: 0.0,
      ),
      body: StoreConnector<AppState, AppState>(
          onInit: (store) => store.dispatch(getArticlesAction),
          converter: (store) => store.state,
          builder: (_, state) {
            return state.articles == []
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          //Categories
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            height: 70,
                            child: ListView.builder(
                              itemCount: categories.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return CategoryTile(
                                  imageUrl: categories[index].imageUrl,
                                  categoryName: categories[index].categoryName,
                                );
                              },
                            ),
                          ),

                          //Blogs
                          Container(
                            padding: const EdgeInsets.only(
                              top: 16,
                            ),
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics:
                                    const ClampingScrollPhysics(), //Allows listview.builder to scroll
                                itemCount: state.articles.length,
                                itemBuilder: (context, index) {
                                  return BlogTile(
                                    imageUrl: state.articles[index].urlToImage,
                                    title: state.articles[index].title,
                                    desc: state.articles[index].description,
                                    url: state.articles[index].url,
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  );
          }),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String? imageUrl;
  final String? categoryName;

  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryNews(
              category: categoryName!.toLowerCase(),
            ),
          ),
        ); //Because the categories were in capital
      },
      child: Container(
        margin: const EdgeInsets.only(
          right: 16,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: imageUrl!,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(
                categoryName!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String? imageUrl, title, desc, url;

  BlogTile({
    @required this.imageUrl,
    @required this.title,
    @required this.desc,
    @required this.url,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(
              blogUrl: url,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: 16.0,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imageUrl!,
              ),
            ),
            Text(
              title!,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              desc!,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
