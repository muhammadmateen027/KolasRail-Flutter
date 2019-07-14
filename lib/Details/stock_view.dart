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
  Color _color = Colors.green;

  String buttonName = "Confirm Delivery";

  bool buttonState = true;

  void _buttonChange() {
    _changeStates();
    logs["status"] = "5";
    _serverUpdate(body: logs);
  }

  void _changeStates() {
    setState(() {
      buttonState = false;
      buttonName = "Delivered";
      _color = Colors.grey;
    });


  }

  @override
  Widget build(BuildContext context) {
    list = new List();
    list.add(widget.args[0].toString());
    list.add(widget.args[1].toString());

    logs = new Map<String, dynamic>();
    logs["email"] = widget.args[0];
    logs["password"] = widget.args[1];
    logs["req_id"] = widget.args[2];

    print("ReqStat: "+widget.args[3]);

    if(widget.args[3] == "5") _changeStates();
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: Text("Stock List"),
        backgroundColor: const Color(0xFFff8b54),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: buttonState ? _buttonChange : null,
        // onPressed: () {
        //   logs["status"] = "5";
        //   _serverUpdate(body: logs);
        // },

        icon: Icon(Icons.local_shipping),
        label: Text(buttonName),
        backgroundColor: _color,
      ),
      backgroundColor: Color.fromRGBO(40, 55, 77, 1.0),
      body: Container(
        decoration: app.appBackground(),
        child: Center(
          child: new Container(
            alignment: Alignment(-1.0, -1.0),
            child: FutureBuilder<Stock>(
                future: fetchData(body: logs),
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
                        Stock pr = snapshot.data;
                        return new ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount:
                              pr.success == null ? 1 : pr.success.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            print(index.toString() +
                                ": Length: " +
                                pr.success.length.toString());
                            if (index == 0) {
                              // return the header
                              // if (pr.reqStatus == 3) {
                              //   setState(() {
                              //     buttonName = "Delivered";
                              //   });
                              // }
                              return getHeadings(pr);
                            }
                            index -= 1;
                            return getCard(
                              context,
                              pr.success[index],
                            );
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

    print("Requested Quantity: " + lesson.appQty);

    return new ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Container(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            // padding: const EdgeInsets.all(8.0),
            width: MediaQuery.of(context).size.width * 0.7,
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
                  lesson.appQty.toString(),
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
                  lesson.appComment.toString(),
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

  ListTile getHeadings(Stock lesson) {
    // if (lesson.reqStatus == 5) {
    //   _changeStates();
    // }
    print("Request Stat: " + lesson.reqStatus.toString());

    // logs["status"] = "5";
    return new ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Container(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Container(
          //   child: Text(
          //     "Project: ",
          //     style: TextStyle(
          //         color: Colors.black45, fontWeight: FontWeight.normal),
          //   ),
          // ),
          Container(
            child: Text(
              lesson.project.toString(),
              style:
                  TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),
            ),
          ),
        ]),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
      subtitle: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "Document: ",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Text(
                    lesson.document.toString(),
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "Created By: ",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Text(
                    lesson.createBy.toString(),
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "Origin: ",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    lesson.originName.toString() +
                        '[' +
                        lesson.originCode.toString() +
                        ']' +
                        ', ' +
                        lesson.originAddress +
                        ', ' +
                        lesson.originZip.toString() +
                        ', ' +
                        lesson.originState.toString() +
                        '.',
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "Destination: ",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    lesson.destinationName +
                        '[' +
                        lesson.destinationCode.toString() +
                        ']' +
                        ', ' +
                        lesson.destinationAddress +
                        ', ' +
                        lesson.destinationZip.toString() +
                        ', ' +
                        lesson.destinationState.toString() +
                        '.',
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "Created at: ",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Text(
                    lesson.createdAt.toString(),
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // onTap: () =>
      //     {Navigator.of(context).pushNamed('/detailPage', arguments: list)},
    );
  }

  _serverUpdate({Map body}) async {
    final response = await http.post(BASE_URL + '/api/update', body: body);
    if (response.statusCode == 200) {
      // print(response.body);
      // setState(() {
      //   buttonName = "Delivered";
      //   // Navigator.of(context).pop();
      // });
      // _createToast('Delivery confirmed.');
      return User.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
