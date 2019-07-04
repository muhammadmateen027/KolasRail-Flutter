import 'package:flutter/material.dart';
import 'login/Login.dart';
import 'delivery_list/list/listview.dart';

void main() => runApp(MainPage());

class MainPage extends StatelessWidget{
  final appTitle = 'Kolas Rail';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: appTitle,
      home: HomePage(title: appTitle,),
    );
  }
}

class HomePage extends StatelessWidget{
  final String title;
  HomePage({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Login(title:title);
  }
}