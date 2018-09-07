import 'package:json_annotation/json_annotation.dart';
import 'package:api_test/models/source.dart';

part 'news.g.dart';

@JsonSerializable()
class News  {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;

  News(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt});

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["source"] = source;
    map["author"] = author;
    map["title"] = title;
    map["description"] = description;
    map["url"] = url;
    map["urlToImage"] = urlToImage;
    map["publishedAt"] = publishedAt;
    return map;
  }

  static fromMap(Map map) {
    News news = new News();
    news.source = Source.fromJson(map["source"]);
    news.author = map["author"];
    news.title = map["title"];
    news.description = map["description"];
    news.url = map["url"];
    news.urlToImage = map["urlToImage"];
    news.publishedAt = map["publishedAt"];
    return news;
  }

  static final columns = [
    "source",
    "author",
    "title",
    "description",
    "url",
    "urlToImage",
    "publishedAt"
  ];

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);

}
