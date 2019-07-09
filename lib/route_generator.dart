import 'package:flutter/material.dart';
import 'login/Login.dart';
import 'delivery_list/list/listview.dart';
import 'package:kolas_rail/Details/stock_page.dart';

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
      case '/stockList':
        if(args is int) {
          return MaterialPageRoute(builder: (_) => StockItemDetail(itemId: args,));
        } else {
          print("Type is not confimed:"+ args.toString());
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
