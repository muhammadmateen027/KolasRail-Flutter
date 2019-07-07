import 'package:flutter/material.dart';
import 'login/Login.dart';
import 'delivery_list/list/listview.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    final args = setting.arguments;

    switch(setting.name) {
      case '/': 
       return MaterialPageRoute(builder: (_) => Login());
      case '/deliveryList':
        // validation of correct data type
        if(args is List<String>) {
          return MaterialPageRoute(builder: (_) => ListPage(args: args,));
        }
        return _errorRoute();
      default: 
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text("Error"),),
          body: Center(child: Text("ERROR"),),
        );
      }
    );
  }
}
