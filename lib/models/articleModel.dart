import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'articleModel.freezed.dart';
part 'articleModel.g.dart';

@immutable
@freezed
class ArticleModel with _$ArticleModel {
  const ArticleModel._();

  // ignore: invalid_annotation_target
  @JsonSerializable()
  factory ArticleModel({
    required String author,
    required String title,
    required String description,
    required String url,
    String? urlToImage,
    required String content,
  }) = _ArticleModel;

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
}
