import "package:flutter/material.dart";
import 'package:flutter/services.dart';

import '../constants/stacked_icons.dart';
import '../delivery_list/listview.dart';

class Login extends StatelessWidget {
  final String title;
  AppBackground app = new AppBackground();

  Login({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
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
            child: SingleChildScrollView(
              child: LoginPageContent(),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginPageContent extends StatefulWidget {
  createState() => LoginState();
}

class LoginState extends State<LoginPageContent> {
  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        new StackedIcons(),
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
                  controller: _textController,
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
                  obscureText: true,
                  decoration: new InputDecoration(labelText: 'Password'),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                child: GestureDetector(
                    onTap: () => _onLoginTapped(context),
                    child: Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      decoration: new BoxDecoration(
                          color: const Color(0xFFff8b54),
                          borderRadius: new BorderRadius.circular(5.0)),
                      child: new Text(
                        "SignIn",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: new Container(
                  alignment: Alignment.center,
                  height: 60.0,
                  child: new Text(
                    "Forgot password?",
                    style: new TextStyle(fontSize: 17.0, color: Colors.black54),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void _onLoginTapped(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => new ListPage(title: 'Lessons'),
        ));
  }
}

// class CustomLoginPage extends StatefulWidget {
//   @override
//   createState() => LoginStatedWidget();
// }

// class LoginStatedWidget extends State<CustomLoginPage> {
//   final TextEditingController _textController = new TextEditingController();
//   FocusNode emailNode = FocusNode();
//   FocusNode passawordNode = FocusNode();

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
//       child: Scaffold(
//         backgroundColor: Color.fromRGBO(40, 55, 77, 1.0),
//         body: SingleChildScrollView(
//           child: LoginPageContent(),
//         ),
//       ),
//     );
//   }
// }
