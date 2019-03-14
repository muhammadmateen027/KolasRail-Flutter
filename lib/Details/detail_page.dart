import 'package:flutter/material.dart';
import '../delivery_list/model/lessons.dart';
// https://github.com/fabiomsr/Flutter-StepByStep
// https://proandroiddev.com/flutter-thursday-02-beautiful-list-ui-and-detail-page-a9245f5ceaf0

class DetailPage extends StatefulWidget {
  DetailPage(
    {
      Key key, 
      this.lesson
      }
    ) : super(key: key);
  final Lesson lesson;
  
  createState() => _DetailPageClass();
}

class _DetailPageClass extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold();
  }

}