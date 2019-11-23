import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Assignments extends StatefulWidget{
  AssignmentsState createState()=> AssignmentsState();
}

class AssignmentsState extends State<Assignments>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Coming Soon!", style: TextStyle(fontSize: 18),)
      ),
    );
  }

}