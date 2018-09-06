import 'package:flutter/material.dart';
import 'package:api_test/pages/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new MaterialApp(
        title: 'Testapp',
        theme: new ThemeData(
          primarySwatch: Colors.deepPurple
        ),
        home: _prepareHomePage(),
      );
    }
}

Widget _prepareHomePage() {
  return new HomePage();
}