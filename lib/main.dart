import 'package:flutter/material.dart';
import 'route_generator.dart';

void main() => runApp(MainPage());

class MainPage extends StatelessWidget{
  final appTitle = 'Kolas Rail';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: appTitle,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}