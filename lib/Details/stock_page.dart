import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:kolas_rail/constants/stacked_icons.dart';
import 'package:kolas_rail/model/stock_items.dart';
import 'dart:async';
import 'dart:convert';
import 'package:kolas_rail/model/usermodel.dart';



class StockItemDetail extends StatefulWidget {
  final List<String> args;
  StockItemDetail({Key key, @required this.args}) : super(key: key);
  createState() => _ListPageState();
}

class _ListPageState extends State<StockItemDetail> {
  List<String> list;
  var logs;
  AppBackground app = new AppBackground();
  @override
  Widget build(BuildContext context) {
    list = new List();
    list.add(widget.args[0].toString());
    list.add(widget.args[1].toString());

    logs = new Map<String, dynamic>();
    logs["email"] = widget.args[0];
    logs["password"] = widget.args[1];
    logs["req_id"] = widget.args[2];
    // TODO: implement build
    return Scaffold(
      // appBar: topAppBar(appName),
      appBar: new AppBar(
        title: Text("Stock List"),
        backgroundColor: const Color(0xFFff8b54),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Color.fromRGBO(40, 55, 77, 1.0),
      // drawer: app.appDrawer(context),
      // bottomNavigationBar: makeBottom,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          logs["status"] = "5";
          _serverUpdate(body: logs);
        },
        icon: Icon(Icons.local_shipping),
        label: Text("Confirm delivery"),
        backgroundColor: Colors.green,
        
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: app.appBackground(),
          child: Center(
            child: new Container(
              alignment: Alignment(-1.0, -1.0),
              child: Column(
                children: <Widget>[
                  // Container(
                  //     child: Text(
                  //   widget.args[1],
                  //   style: TextStyle(
                  //       color: Colors.black45,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 18.0),
                  // )),
                  FutureBuilder<Stock>(
                      future: fetchData(body: logs),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return new Text('Input a URL to start');
                          case ConnectionState.waiting:
                            return new Center(
                                child: new CircularProgressIndicator());
                          case ConnectionState.active:
                            return new Text('');
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return new Text(
                                '${snapshot.error}',
                                style: TextStyle(color: Colors.black),
                              );
                            } else {
                              Stock pr = snapshot.data;
                              return new ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: pr.success.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return getCard(
                                    context,
                                    pr.success[index],
                                  );
                                },
                              );
                            }
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Stock> fetchData({Map body}) async {

    final response = await http.post(BASE_URL + '/api/stocklist', body: logs);

    if (response.statusCode == 200) {
      return Stock.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Card getCard(BuildContext context, Success success) {
    return new Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white70),
        child: getTile(context, success),
      ),
    );
  }

  ListTile getTile(BuildContext context, Success lesson) {
    List<String> list = new List();
    list.add(widget.args[0]);
    list.add(widget.args[1]);
    list.add(lesson.rid.toString());

    return new ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Container(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            // padding: const EdgeInsets.all(8.0),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              lesson.iname.trimRight(),
              style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ),
        ]),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Comment: ",
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                child: Text(
                  lesson.comment.toString(),
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Category: ",
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                child: Text(
                  lesson.category.toString(),
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Unit: ",
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                child: Text(
                  lesson.unit.toString(),
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Approved Quantity: ",
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                child: Text(
                  lesson.app_qty.toString(),
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Approved Comments: ",
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                child: Text(
                  lesson.app_comment.toString(),
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Date: ",
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                child: Text(
                  lesson.added.toString(),
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),

      // onTap: () =>
      //     {Navigator.of(context).pushNamed('/detailPage', arguments: list)},
    );
  }

  Future<User> _serverUpdate({Map body}) async {
    final response = await http.post(BASE_URL + '/api/update', body: body);
    if (response.statusCode == 200) {
      // _createToast('Delivery confirmed.');
      return User.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

}
