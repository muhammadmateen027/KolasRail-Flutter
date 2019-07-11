import 'package:flutter/material.dart';
import 'package:kolas_rail/model/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListItems {
  Card getCard(
      BuildContext context, Success lesson, String email, String password) {
    return new Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white70),
        child: getTile(context, lesson, email, password),
      ),
    );
  }

  ListTile getTile(
      BuildContext context, Success lesson, String email, String password) {
    String status = "";
    int color;

    List<String> list = new List();
    list.add(email);
    list.add(password);
    list.add(lesson.reqId.toString());
    list.add(lesson.project.toString());
    list.add(lesson.document.toString());
    list.add(lesson.desc.toString());
    list.add(lesson.originName.toString());
    list.add(lesson.originAddress.toString());
    list.add(lesson.destinationName.toString());
    list.add(lesson.destinationAddress.toString());

    // List xs = [
    //             lesson.project.toString(),
    //              lesson.document.toString(),
    //              lesson.desc.toString(),
    //              lesson.originName.toString(),
    //              lesson.originAddress.toString(),
    //              lesson.destinationName.toString(),
    //              lesson.destinationAddress.toString()
    //           ];

    if (lesson.reqStatus == 3) {
      color = 0xFFff8b54;
      status = "Pending";
    } else if (lesson.reqStatus == 5) {
      status = "Delivered";
      color = 0xFF009933;
    } else {
      status = "Unknown";
    }

    return new ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Container(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            lesson.project.trimRight(),
            style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.bold,
                fontSize: 18.0),
          ),
          new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10.0),
                child: getSmallTick(lesson.reqStatus),
              ),
              Container(
                child: Text(
                  status,
                  style: TextStyle(
                      color: Color(color), fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ]),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: Text(
              lesson.document,
              style: TextStyle(
                  color: Colors.black45, fontWeight: FontWeight.normal),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Origin: ",
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                child: Text(
                  lesson.originName,
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
                  "Destination: ",
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                child: Text(
                  lesson.destinationName,
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),

      onTap: () => pushToActivity(context, list),
    );
  }

  // goto Next Activity as
  void pushToActivity(BuildContext context, List<String> list) {
    Navigator.of(context).pushNamed('/stockList', arguments: list);
  }


  Stack getSmallTick(int reqStatus) {
    int color;
    IconData icon;
    if (reqStatus == 3) {
      color = 0xFFff8b54;
      icon = Icons.timer;
    } else {
      color = 0xFF009933;
      icon = Icons.check;
    }

    return new Stack(
      alignment: Alignment.center,
      children: <Widget>[
        new Container(
          height: 15.0,
          width: 15.0,
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(50.0),
              color: Color(color)),
          child: new Icon(
            icon,
            color: Colors.white,
            size: 10.0,
          ),
        ), //local_offer
      ],
    );
  }
}
