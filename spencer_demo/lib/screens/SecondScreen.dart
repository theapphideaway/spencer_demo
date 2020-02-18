import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  SecondScreenState createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SecondScreen"),
      leading: GestureDetector(
          onTap: ()=> print("Back Tapped, it doesnt actually go back lol"),
          child: Icon(Icons.arrow_back_ios)),),

      body: SafeArea(
          child: Column(children: <Widget>[
            Expanded(child: Container(
              color: Colors.green,
            )),
            Expanded(child: Container(
              color: Colors.blue,
            )),
            Expanded(child: Container(
              color: Colors.red,
            )),
            Expanded(child: Container(
              color: Colors.brown,
            ))
          ],)),
    );
  }
}