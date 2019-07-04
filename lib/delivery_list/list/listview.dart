import 'package:flutter/material.dart';
import '../../constants/stacked_icons.dart';
import 'items/item_list.dart';
import 'model/lessons.dart';
import 'package:bmprogresshud/bmprogresshud.dart';
import 'model/item.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

// https://github.com/fabiomsr/Flutter-StepByStep
// https://proandroiddev.com/flutter-thursday-02-beautiful-list-ui-and-detail-page-a9245f5ceaf0

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title, this.email, this.password}) : super(key: key);
  final String title;
  final String email;
  final String password;
  createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List lessons;
  AppBackground app = new AppBackground();
  ListItems lItem = new ListItems();
  Lesson lessonClass = new Lesson();

  final String appName = "Kolas Rail";
  final String tabName = "Delivery List";

  @override
  void initState() {
    // ProgressHud.of(context).show(ProgressHudType.loading, "Loading...");

    lessons = lessonClass.getLessons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.email);
    print(widget.password);
    return Scaffold(
      // appBar: topAppBar(appName),
      appBar: new AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFFff8b54),
      ),
      backgroundColor: Color.fromRGBO(40, 55, 77, 1.0),
      drawer: app.appDrawer(context),
      bottomNavigationBar: makeBottom,
      body: FutureBuilder<List<DeliveryItem>>(
        future: fetchPhotos(widget.email, widget.password, http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? DeliveryItemList(photos: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
      // body: ProgressHud(
      //   child: Container(
      //     decoration: app.appBackground(),
      //     child: Center(
      //       child: new Container(
      //         alignment: Alignment(-1.0, -1.0),
      //         child: ListView.builder(
      //           scrollDirection: Axis.vertical,
      //           shrinkWrap: true,
      //           itemCount: lessons.length,
      //           itemBuilder: (BuildContext context, int index) {
      //             return lItem.getCard(context, lessons[index]);
      //           },
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
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

  // A function that converts a response body into a List<Photo>.
  List<DeliveryItem> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    print(parsed
        .map<DeliveryItem>((json) => DeliveryItem.fromJson(json))
        .toList());
    return null;
    // return parsed
    //     .map<DeliveryItem>((json) => DeliveryItem.fromJson(json))
    //     .toList();
  }

  Future<List<DeliveryItem>> fetchPhotos(
    String email,
    String password,
    http.Client client,
  ) async {
    var logs = new Map<String, dynamic>();
    logs["email"] = email;
    logs["password"] = password;

    final response = await http.post(BASE_URL + '/api/list', body: logs);

    // Use the compute function to run parsePhotos in a separate isolate.
    print(response.body);
    return compute(parsePhotos, response.body);
  }
}

class DeliveryItemList extends StatelessWidget {
  final List<DeliveryItem> photos;

  DeliveryItemList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        print('Mateen: =====>> ' + photos[index].success.toString());
        return Text(photos[index].success.toString());
        // return Image.network(photos[index].thumbnailUrl);
      },
    );
  }
}
