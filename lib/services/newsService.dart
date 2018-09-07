import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:api_test/models/apiResponse.dart';
import 'package:api_test/models/news.dart';

class NewsService {
  final url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=32f9515688d64ef7b21040ff7206d1b6";

  Future<List<News>> getAll() async {
    final response = await http.get(this.url);
    if(response.statusCode ==200) {
      Map theMap = json.decode(response.body.toString());
      var apiResponse = ApiResponse.fromJson(theMap);
      List<News> newsList = createnewsList(apiResponse);
      return newsList;
    } else {
      throw Exception('Failed to load the news ');
    }
  }

  List<News> createnewsList(ApiResponse data){
    List<News> news = new List();
    for(int i = 0; i < data.articles.length; i++) {
      var temp = News.fromJson((data.articles[i]));
      news.add(temp);
    }
    return news;
  }

}