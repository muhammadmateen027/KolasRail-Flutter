import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kolas_rail/constants/stacked_icons.dart';
import 'package:kolas_rail/model/stock_items.dart';
import 'dart:async';
import 'dart:convert';

class StockItemDetail extends StatefulWidget {
  final List<String> args;
  StockItemDetail({Key key, @required this.args}) : super(key: key);
  createState() => _ListPageState();
}

class _ListPageState extends State<StockItemDetail> {
  @override
  Widget build(BuildContext context) {
    fetchData();
    // TODO: implement build
    return Scaffold();
  }

  Future<Stock> fetchData() async {

    var logs = new Map<String, dynamic>();
    logs["email"] = "alif@driver.com";
    logs["password"] = "123456";
    logs["req_id"] = "3";

    final response = await http.post(BASE_URL + '/api/stocklist', body: logs);

    if (response.statusCode == 200) {
      print("**************************************");
      print(response.body);
      // return  compute(parsePhotos, response.body);

      return Stock.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
