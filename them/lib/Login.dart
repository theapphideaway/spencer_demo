import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          Expanded(child: Container()),
          Padding(padding: EdgeInsets.all(0),
          child: Text("Them", style: TextStyle(fontSize: 32),)),
          Expanded(child: Container())
        ],
      )),
    );
  }
}
