import 'dart:async';
import 'package:flutter/material.dart';
import 'package:api_test/models/news.dart';
import 'package:api_test/services/newsService.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:api_test/widgets/news_detail.dart';

Future<Null> testRefresh() async {
  Future.delayed(Duration(seconds: 5));
  
  
  return null;
}

String _verifyImageUrl(String url) {
  if (url != null) {
    return url;
  } else {
    return 'https://www.foot.com/wp-content/uploads/2017/03/placeholder.gif';
  }
}
 class NewsSection extends StatefulWidget{
     final formatter = new DateFormat.yMMMMd("en_US");

   @override
     State<StatefulWidget> createState() {
       // TODO: implement createState
       return NewsSectionState();
     }
 }

class NewsSectionState extends State<NewsSection> {
  NewsService _newsService = new NewsService();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Center(
        child: FutureBuilder<List<News>>(
            future: _newsService.getAll(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return RefreshIndicator(
                    onRefresh: testRefresh,
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new ListTile(
                                title: new Text(snapshot.data[index].title),
                                subtitle: new Container(
                                    margin: EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      widget.formatter.format(DateTime.parse(
                                          snapshot.data[index].publishedAt)),

                                      //  snapshot.data[index].publishedAt
                                    )),
                                isThreeLine: true,
                                leading: Container(
                                  child: new CachedNetworkImage(
                                      imageUrl: _verifyImageUrl(
                                          snapshot.data[index].urlToImage),
                                      fit: BoxFit.cover,
                                      width: 100.0,
                                      height: 65.0,
                                      placeholder: new Image.asset(
                                          "images/img_placeholder.png",
                                          width: 100.0,
                                          height: 65.0)),
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (_){
                                      return  NewsDetailSection(news: snapshot.data[index]);
                                    } 
                                  ));
                                },
                                ),
                            new Divider()
                          ],
                        );
                      },
                    ));
              } else {}
              return CircularProgressIndicator();
            }));
  }
}
