import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kolas_rail/constants/stacked_icons.dart';

class StockItemDetail extends StatelessWidget {
  final int itemId;
  StockItemDetail({Key key, @required this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("InStock: "+ itemId.toString());
    // TODO: implement build
    return Container();
  }


}