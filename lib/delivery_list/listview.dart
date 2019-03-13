import 'package:flutter/material.dart';
import '../constants/stacked_icons.dart';
import 'items/item_list.dart';
// https://github.com/fabiomsr/Flutter-StepByStep
// https://proandroiddev.com/flutter-thursday-02-beautiful-list-ui-and-detail-page-a9245f5ceaf0

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);
  final String title;
  createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  AppBackground app = new AppBackground();
  ListItems lItem = new ListItems();

  final String appName = "Kolas Rail";
  final String tabName = "Delivery List";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: topAppBar(appName),
      appBar: new AppBar(
        title: Text(tabName),
        backgroundColor: const Color(0xFFff8b54),
      ),
      backgroundColor: Color.fromRGBO(40, 55, 77, 1.0),
      drawer: app.appDrawer(context),
      // bottomNavigationBar: makeBottom,
      body: Container(
        decoration: app.appBackground(),
        child: Center(
            child: new Container(
            alignment: Alignment(-1.0, -1.0),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return lItem.getCard();
              },
            ),
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

  // Create Body
  // final makeBody = Container(
  //   child: ListView.builder(
  //     scrollDirection: Axis.vertical,
  //     shrinkWrap: true,
  //     itemCount: 10,
  //     itemBuilder: (BuildContext context, int index) {
  //       return new Card(
  //         elevation: 8.0,
  //         margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
  //         child: Container(
  //           decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
  //           child: new ListTile(
  //             contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  //             leading: Container(
  //               padding: EdgeInsets.only(right: 12.0),
  //               decoration: new BoxDecoration(
  //                   border: new Border(
  //                       right: new BorderSide(width: 1.0, color: Colors.white24))),
  //               child: Icon(Icons.autorenew, color: Colors.white),
  //             ),
  //             title: Text(
  //               "Introduction to Driving",
  //               style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //             ),
  //             // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

  //             subtitle: Row(
  //               children: <Widget>[
  //                 Icon(Icons.linear_scale, color: Colors.yellowAccent),
  //                 Text(" Intermediate", style: TextStyle(color: Colors.white))
  //               ],
  //             ),
  //             trailing:
  //                 Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)),
  //         ),
  //       );
  //     },
  //   ),
  // );

  // create Cards

  // Items inside card
  // final makeListTile = new ListTile(
  //     contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  //     leading: Container(
  //       padding: EdgeInsets.only(right: 12.0),
  //       decoration: new BoxDecoration(
  //           border: new Border(
  //               right: new BorderSide(width: 1.0, color: Colors.white24))),
  //       child: Icon(Icons.autorenew, color: Colors.white),
  //     ),
  //     title: Text(
  //       "Introduction to Driving",
  //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //     ),
  //     // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

  //     subtitle: Row(
  //       children: <Widget>[
  //         Icon(Icons.linear_scale, color: Colors.yellowAccent),
  //         Text(" Intermediate", style: TextStyle(color: Colors.white))
  //       ],
  //     ),
  //     trailing:
  //         Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0));
}
