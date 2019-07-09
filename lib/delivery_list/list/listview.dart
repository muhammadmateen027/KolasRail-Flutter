import 'package:flutter/material.dart';
import '../../constants/stacked_icons.dart';
import 'items/item_list.dart';
import 'package:kolas_rail/model/item.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

// https://github.com/fabiomsr/Flutter-StepByStep
// https://proandroiddev.com/flutter-thursday-02-beautiful-list-ui-and-detail-page-a9245f5ceaf0

class ListPage extends StatefulWidget {
  final List<String> args;
  final String title = "Delivery List";
  final String email = "";
  final String password = "";

  ListPage(
    {
      Key key, 
      @required this.args,
      }
    ) : super(key: key);
  
  
  createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  var logs;
  List lessons;
  AppBackground app = new AppBackground();
  ListItems lItem = new ListItems();
  List<Product> items = List();

  final String appName = "Kolas Rail";

  @override
  void initState() {
    // ProgressHud.of(context).show(ProgressHudType.loading, "Loading...");

    logs = new Map<String, dynamic>();
    logs["email"] = widget.args[0];
    logs["password"] = widget.args[1];

    lItem = new ListItems();
    super.initState();
  }
    Future<List> _getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getStringList('auth') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: topAppBar(appName),
      appBar: new AppBar(
        title: Text("Delivery List"),
        backgroundColor: const Color(0xFFff8b54),
      ),
      backgroundColor: Color.fromRGBO(40, 55, 77, 1.0),
      drawer: app.appDrawer(context),
      body: Container(
        decoration: app.appBackground(),
        child: Center(
          child: new Container(
            alignment: Alignment(-1.0, -1.0),
            child: FutureBuilder<Product>(
                future: fetchData(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return new Text('Input a URL to start');
                    case ConnectionState.waiting:
                      return new Center(child: new CircularProgressIndicator());
                    case ConnectionState.active:
                      return new Text('');
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return new Text(
                          '${snapshot.error}',
                          style: TextStyle(color: Colors.black),
                        );
                      } else {
                        // print("==>> " + snapshot.data);
                        Product pr = snapshot.data;
                        return new ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: pr.success.length,
                          itemBuilder: (BuildContext context, int index) {
                            return lItem.getCard(context, pr.success[index], widget.args[0], widget.args[1]);
                          },
                        );
                      }
                  }
                }),
          ),
        ),
      ),
    );
  }

  //Top App bar with Right Icon
  final topAppBar = (String appTitle) => AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text(appTitle),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {},
          )
        ],
      );

  // Bottom Icons and bar
  final makeBottom = Container(
    height: 55.0,
    child: BottomAppBar(
      color: Color.fromRGBO(58, 66, 86, 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.blur_on, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.hotel, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_box, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
    ),
  );

  Future<Product> fetchData() async {
    final response = await http.post(BASE_URL + '/api/list', body: logs);

    if (response.statusCode == 200) {
      // print("**************************************");
      // return  compute(parsePhotos, response.body);

      return Product.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
