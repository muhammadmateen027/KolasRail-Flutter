import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kolas_rail/constants/stacked_icons.dart';
import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:kolas_rail/model/usermodel.dart';

import 'dart:async';
import 'dart:convert';

class Login extends StatelessWidget {
  // final String title;
  AppBackground app;

  Login({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    app = new AppBackground();
    _getSharedPref().then((value) {
      if (value.length > 0) {
        List<String> list = new List();
        list.add(value[0]);
        list.add(value[1]);
        Navigator.pushReplacementNamed(context, '/deliveryList',
            arguments: list);
      }
    });
    // TODO: implement build
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // title: Text("Kolas Rail"),
          backgroundColor: const Color(0xFFff8b54),
        ),
        backgroundColor: Color.fromRGBO(40, 55, 77, 1.0),
        // drawer: app.appDrawer(context),
        body: ProgressHud(
          child: Container(
            // Add box decoration
            decoration: app.appBackground(),
            child: Center(
              child: SingleChildScrollView(
                child: LoginPageContent(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<List> _getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getStringList('auth') ?? [];
  }
}

class LoginPageContent extends StatefulWidget {
  createState() => LoginState();
}

class LoginState extends State<LoginPageContent> {
  final TextEditingController _emailtextController =
      new TextEditingController();
  final TextEditingController _passwodtextController =
      new TextEditingController();

  _showLoadingHud(BuildContext context) {
    ProgressHud.of(context).show(ProgressHudType.loading, "Loading...");
    // ProgressHud.of(context).dismiss();
  }

  @override
  Widget build(BuildContext context) {
    print("Hello World");
    // TODO: implement build
    return Column(
      children: <Widget>[
        // _progressHUD,
        // new StackedIcons(),
        Container(
            height: 90,
            width: 90,
            child: Image.asset('assets/playstore-icon.png')),

        new AppName(),
        new Container(
          width: MediaQuery.of(context).size.width - 30,
          height: 300.0,
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(10.0),
              color: Color(0xFFFFFFFF)),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new SizedBox(
                height: 10.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                child: new TextField(
                  controller: _emailtextController,
                  decoration: new InputDecoration(labelText: 'Email'),
                ),
              ),
              new SizedBox(
                height: 10.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                child: new TextField(
                  controller: _passwodtextController,
                  obscureText: true,
                  decoration: new InputDecoration(labelText: 'Password'),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                child: GestureDetector(
                    onTap: () => _onLoginTapped(
                        context,
                        _emailtextController.text.toLowerCase(),
                        _passwodtextController.text.toLowerCase()),
                    child: Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      decoration: new BoxDecoration(
                          color: const Color(0xFFff8b54),
                          borderRadius: new BorderRadius.circular(5.0)),
                      child: new Text(
                        "Sign In",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    )),
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
              //   child: new Container(
              //     alignment: Alignment.center,
              //     height: 60.0,
              //     child: new Text(
              //       "Forgot password?",
              //       style: new TextStyle(fontSize: 17.0, color: Colors.black54),
              //     ),
              //   ),
              // )
            ],
          ),
        )
      ],
    );
  }

  void _onLoginTapped(BuildContext context, String email, String password) {
    if (email.length == 0) {
      _createToast("Email required.");
      return;
    }
    if (!email.contains("@")) {
      _createToast("Wrong email.");
      return;
    }
    if (password.length == 0) {
      _createToast("Password required.");
      return;
    }

    _showLoadingHud(context);
    var logs = new Map<String, dynamic>();
    logs["email"] = email;
    logs["password"] = password;

    Future<User> userResult = _serverLogin(body: logs);
    userResult.then((val) {
      if (val.success.toString() == 'true') {
        _loginTokenSaver(email, password);
        _navigateNext(email, password);
      } else {
        _createToast('Email and password mismatch.');
      }
    });
  }

  _createToast(String msg) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(msg),
      backgroundColor: Colors.blue,
    ));
  }

  Future<User> _serverLogin({Map body}) async {
    final response = await http.post(BASE_URL + '/api/login', body: body);
    ProgressHud.of(context).dismiss();
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      _createToast('Email and password miss-match.');
      throw Exception('Failed to load post');
    }
  }

  _loginTokenSaver(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (email.length != 0 && password.length != 0)
      await prefs
          .setStringList('auth', [email.toString(), password.toString()]);
    // print('Stored Value is: ' + prefs.getStringList('auth').toString() ?? []);
  }

  _navigateNext(String email, String password) {
    List<String> list = new List();
    list.add(email);
    list.add(password);
    Navigator.of(context)
        .pushReplacementNamed('/deliveryList', arguments: list);
    // Navigator.of(context).pop();
  }
}

//http://tphangout.com/flutter-lists-with-json/
