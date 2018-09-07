import 'package:flutter/material.dart';
import 'package:api_test/models/news.dart';
import 'package:intl/intl.dart';

import 'package:cached_network_image/cached_network_image.dart';

String _verifyImageUrl(String url) {
  if (url != null) {
    return url;
  } else {
    return 'https://www.foot.com/wp-content/uploads/2017/03/placeholder.gif';
  }
}


class NewsDetailSection extends StatelessWidget {
  final News news;
  final formatter = new DateFormat.yMMMMd("en_US");

  NewsDetailSection({Key key, @required this.news}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(title: new Text(news.title)),
        body: ListView(children: <Widget>[
          CachedNetworkImage(
            imageUrl: _verifyImageUrl(news.urlToImage),
            fit: BoxFit.cover,
            width: 1000.0,
          ),
          Container(
              padding: EdgeInsets.all(12.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      news.title,
                      style: new TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w300),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              formatter.format(
                                      DateTime.parse(news.publishedAt)) +
                                  "  |  ",
                              style: TextStyle(
                                  fontSize: 12.0, fontWeight: FontWeight.w400),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                news.source.name.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        )),
                    new Divider(),
                    Container(
                      child: Text(
                        news.description,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ]))
        ]));
  }
}
