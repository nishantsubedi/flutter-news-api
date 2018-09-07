import 'package:flutter/material.dart';
import 'package:api_test/widgets/home.dart';
import 'package:api_test/widgets/about.dart';
import 'package:api_test/widgets/news.dart';
import 'package:api_test/widgets/register.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Home", Icons.home),
    new DrawerItem("About", Icons.info),
    new DrawerItem("News", Icons.rss_feed),
    new DrawerItem("Register", Icons.account_box)
  ];
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new HomeSection();
      case 1:
        return new AboutSection();
      case 2:
        return new NewsSection();
      case 3:
        return new RegisterSection();
      default:
        return new Text('Error');
    }
  }

  _onSelectItem(int index) {
    setState(() {
      _selectedDrawerIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return new Scaffold(
        appBar: new AppBar(title: new Text('Title')),
        drawer: new Drawer(
          child: new Column(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                  accountName: new Text("John Doe"),
                  accountEmail: new Text('John@example.com')),
              new Column(
                children: drawerOptions,
              )
            ],
          ),
        ),
        body: _getDrawerItemWidget(_selectedDrawerIndex));
  }
}
