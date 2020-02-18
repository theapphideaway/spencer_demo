import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SecondScreen.dart';

class MainScreen extends StatefulWidget {
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Container(width: 50, height: 50, color: Colors.red),),
      body: SafeArea(
          child: Container(
            color: Colors.green,
          )),
      floatingActionButton: FloatingActionButton(

        child: Icon(Icons.add),
        onPressed: ()=> goToSecondScreen(),
      ),
    );
  }

  goToSecondScreen(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen()));
  }
}
