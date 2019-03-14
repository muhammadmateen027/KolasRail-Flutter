import 'package:flutter/material.dart';
import '../model/lessons.dart';
import '../../Details/detail_page.dart';

class ListItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

  Card getCard(BuildContext context, Lesson lesson) {
    return new Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white70),
        child: getTile(context, lesson),
      ),
    );
  }

  ListTile getTile(BuildContext context, Lesson lesson) {
    return new ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      // leading: Container(
      //   padding: EdgeInsets.only(right: 12.0),
      //   decoration: new BoxDecoration(
      //       border: new Border(
      //           right: new BorderSide(width: 1.0, color: Colors.green))),
      //   child: Icon(Icons.check, color: Colors.green),
      // ),
      // title: Text(
      //   lesson.title,
      //   style: TextStyle(
      //       color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 18.0),
      // ),
      title: Container(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            lesson.title,
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
                child: getSmallTick(lesson.color),
              ),
              Container(
                child: Text(
                  lesson.status,
                  style: TextStyle(
                      color: Color(lesson.color), fontWeight: FontWeight.bold),
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
              lesson.box_label,
              style: TextStyle(
                  color: Colors.black45, fontWeight: FontWeight.normal),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Client: ",
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                child: Text(
                  lesson.client_name,
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
                  "Origin Address: ",
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                child: Text(
                  lesson.address,
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),

      onTap: () => pushToActivity(context, lesson),
    );
  }

  // goto Next Activity as
  void pushToActivity(BuildContext context, Lesson lesson) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPage(lesson: lesson)));
  }

  Stack getSmallTick(int color) {
    return new Stack(
              alignment: Alignment.center,
              children: <Widget>[
                new Container(
                  height: 15.0,
                  width: 15.0,
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(50.0),
                    color: Color(color)
                  ),
                  child: new Icon(Icons.check, color: Colors.white, size: 10.0,),
                ),//local_offer
              ],
              
            );
  }
}
