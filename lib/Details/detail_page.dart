import 'package:flutter/material.dart';
import 'package:kolas_rail/model/item.dart';
import '../constants/stacked_icons.dart';
// https://github.com/fabiomsr/Flutter-StepByStep
// https://proandroiddev.com/flutter-thursday-02-beautiful-list-ui-and-detail-page-a9245f5ceaf0

class DetailPage extends StatefulWidget {
  DetailPage({Key key, this.lesson}) : super(key: key);
  final Success lesson;

  createState() => _DetailPageClass();
}

class _DetailPageClass extends State<DetailPage> {
  AppBackground app = new AppBackground();
  final String title = "Scan & Sign";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFFff8b54),
      ),
      backgroundColor: Color.fromRGBO(40, 55, 77, 1.0),
      drawer: app.appDrawer(context),
      body: Container(
        // Add box decoration
        decoration: app.appBackground(),
        child: Center(
          child: Container(
            // alignment: Alignment(-1.0, -1.0),
            child: SingleChildScrollView(
              child: ScanPageContent(),
            ),
          ),
        ),
      ),
    );
  }
}

class ScanPageContent extends StatefulWidget {
  createState() => ScanningState();
}

class ScanningState extends State<ScanPageContent> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        new Container(
          width: MediaQuery.of(context).size.width - 30,
          height: 470.0,
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(10.0),
              color: Color(0xFFFFFFFF)),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new SizedBox(
                height: 10.0,
              ),
              Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width - 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 1.0),
                    child: Container(
                      child: new TextField(
                        decoration: new InputDecoration(
                          hintText: 'Location',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(width: 1.0, color: Colors.black))),
              new SizedBox(
                height: 10.0,
              ),
              Container(
                  height: 200.0,
                  width: MediaQuery.of(context).size.width - 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 0.0),
                    child: Container(
                      child: new TextField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: new InputDecoration(
                          hintText: 'Sign',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(width: 1.0, color: Colors.black))),
              new SizedBox(
                height: 10.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      decoration: new BoxDecoration(
                          color: const Color(0xFFff8b54),
                          borderRadius: new BorderRadius.circular(5.0)),
                      child: new Text(
                        "Confirm",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 15.0, bottom: 15.0),
                child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      decoration: new BoxDecoration(
                          color: const Color(0xFFffcbb3),
                          borderRadius: new BorderRadius.circular(5.0)),
                      child: new Text(
                        "Cancel",
                        style: new TextStyle(
                            fontSize: 20.0, color: Color(0xFF4d4d4d)),
                      ),
                    )),
              ),
            ],
          ),
        ),
        new Container(
          width: MediaQuery.of(context).size.width - 30,
          height: 80.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
            // child: GestureDetector(
            //     onTap: () {},
            //     child: Container(
            //       alignment: Alignment.center,
            //       height: 60.0,
            //       decoration: new BoxDecoration(
            //           color: const Color(0xFF802b00),
            //           borderRadius: new BorderRadius.circular(5.0)),
            //       child: new Text(
            //         "Take Photo",
            //         style:
            //             new TextStyle(fontSize: 20.0, color: Colors.white),
            //       ),
            //     )),

            child: Center(
                child: new Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 60.0,
                  decoration: new BoxDecoration(
                      color: const Color(0xFF802b00),
                      borderRadius: new BorderRadius.circular(5.0)),
                child: FlatButton.icon(
                  icon: Icon(Icons.add_a_photo, color: Colors.white,), //`Icon` to display
                  label: Text('Add a Photo'), 
                  textColor: Colors.white,
                  
                  //`Text` to display
                  onPressed: () {
                    //Code to execute when Floating Action Button is clicked
                    //...
                  },
                ),
              )
            ),
          ),
        )
      ],
    );
  }
}
