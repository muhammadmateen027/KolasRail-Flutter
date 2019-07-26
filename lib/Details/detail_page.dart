import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:kolas_rail/model/stock_items.dart';
import 'package:http/http.dart' as http;
import '../constants/stacked_icons.dart';
import 'package:kolas_rail/model/usermodel.dart';
import 'package:progress_dialog/progress_dialog.dart';
// https://github.com/fabiomsr/Flutter-StepByStep
// https://proandroiddev.com/flutter-thursday-02-beautiful-list-ui-and-detail-page-a9245f5ceaf0

class DetailPage extends StatefulWidget {
  DetailPage({Key key, this.logsList}) : super(key: key);
  final List logsList;
  createState() => _DetailPageClass();
}

class _DetailPageClass extends State<DetailPage> {
  ProgressDialog pr;
  File _image = null;
  AppBackground app = new AppBackground();
  final String title = "Scan & Sign";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, ProgressDialogType.Normal);
    pr.setMessage('Please wait…');
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFFff8b54),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => _popBack(),
        ),
      ),
      backgroundColor: Color.fromRGBO(40, 55, 77, 1.0),
      body: Container(
        // Add box decoration
        decoration: app.appBackground(),
        child: Center(
          child: Container(
            // alignment: Alignment(-1.0, -1.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  new Container(
                    width: MediaQuery.of(context).size.width - 30,
                    height: 420.0,
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(10.0),
                        color: Color(0xFFFFFFFF)),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // new SizedBox(
                        //   height: 10.0,
                        // ),
                        // Container(
                        //     height: 50.0,
                        //     width: MediaQuery.of(context).size.width - 60,
                        //     child: Padding(
                        //       padding: const EdgeInsets.symmetric(
                        //           horizontal: 10.0, vertical: 1.0),
                        //       child: Container(
                        //         child: new TextField(
                        //           decoration: new InputDecoration(
                        //             hintText: 'Location',
                        //             border: InputBorder.none,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     decoration: new BoxDecoration(
                        //         borderRadius: BorderRadius.circular(5.0),
                        //         border: Border.all(width: 1.0, color: Colors.black))),
                        new SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          child: Container(
                              height: 200.0,
                              width: MediaQuery.of(context).size.width - 60,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 0.0),
                                child: Container(
                                    child: _image == null
                                        ? new Center(
                                            child: new Image.asset(
                                                "assets/camera_icon.png"),
                                          )
                                        : Image.file(File(_image.path))
                                    // child: Image.file(File(_image.path)),
                                    ),
                              ),
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      width: 1.0, color: Colors.black))),
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 30.0),
                          child: GestureDetector(
                              onTap: () {
                                _upload(_image);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 60.0,
                                decoration: new BoxDecoration(
                                    color: const Color(0xFFff8b54),
                                    borderRadius:
                                        new BorderRadius.circular(5.0)),
                                child: new Text(
                                  "Confirm",
                                  style: new TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 15.0, bottom: 15.0),
                          child: GestureDetector(
                              onTap: () => _popBack(),
                              child: Container(
                                alignment: Alignment.center,
                                height: 60.0,
                                decoration: new BoxDecoration(
                                    color: const Color(0xFFffcbb3),
                                    borderRadius:
                                        new BorderRadius.circular(5.0)),
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
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 30.0),
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
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ), //`Icon` to display
                          label: Text('Add a Photo'),
                          textColor: Colors.white,

                          //`Text` to display
                          onPressed: () {
                            _choose().then((image) {
                              image.path;
                              setState(() {
                                _image = image;
                                pr.hide();
                              });
                            });
                            //Code to execute when Floating Action Button is clicked
                            //...
                          },
                        ),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<File> _choose() async {
    pr.show();
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    return image;
// file = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  void _upload(File file) {
    if (file == null) return;
    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path.split("/").last;

    // print("Image Base64: " + base64Image.toString());
    // print("Image Name: " + fileName.toString());

    var logs = new Map<String, dynamic>();
    logs["email"] = widget.logsList[0];
    logs["password"] = widget.logsList[1];
    logs["req_id"] = widget.logsList[2];
    logs["image"] = base64Image;
    logs["status"] = "5";

    _serverUpdate(body: logs).then((onValue) {
      pr.hide();
      if (onValue.success == 'true')
        _popBack();
      else
        print(onValue.toString());
    });
//    http.post(phpEndPoint, body: {
//      "image": base64Image,
//      "name": fileName,
//    }).then((res) {
//      print(res.statusCode);
//    }).catchError((err) {
//      print(err);
//    });
  }

  Future<User> _serverUpdate({Map body}) async {
    pr.show();
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
      throw Exception('\n\nFailed to load post\n\n');
    }
  }

  _popBack() {
    Navigator.of(context).pop();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response == null) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.type == RetrieveType.image) {
          print("Image: " + response.file.toString());
          _upload(response.file);
          // _handleImage(response.file);
        }
      });
    } else {
      print(response.exception.toString());
      // _handleError(response.exception);
    }
  }
}
