import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenteeCertainty extends StatefulWidget {
  final int certaintyValue;
  MenteeCertainty({Key key, @required this.certaintyValue});
  MenteeCertaintyState createState() => MenteeCertaintyState(certaintyValue);
}

class MenteeCertaintyState extends State<MenteeCertainty> {
  int _certaintyValue ;

  MenteeCertaintyState (int certainty){
    _certaintyValue = certainty;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black.withOpacity(0.30),
      body: Padding(
        padding: EdgeInsets.only(top: 550),
        child: Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0))),
            child: Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    FlatButton(
                        onPressed: () => {Navigator.pop(context)},
                        child: Icon(Icons.clear)),
                    Expanded(child:Container()),
                    FlatButton(
                        onPressed: onSave,
                        child: Icon(Icons.done)),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "How certain are you?",
                          style: TextStyle(fontSize: 16),
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: new Column(
                        children: <Widget>[
                          new Padding(
                              padding: EdgeInsets.only(left: 0, right: 0),
                              child: Row(children: <Widget>[Radio(
                                value: 0,
                                groupValue: _certaintyValue,
                                onChanged: _handleExperienceValueChange,
                              ),
                                new Text(
                                  "100% certain",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],)),

                          new Padding(
                              padding: EdgeInsets.only(left: 0, right: 0),
                              child: Row(children: <Widget>[Radio(
                                value: 1,
                                groupValue: _certaintyValue,
                                onChanged: _handleExperienceValueChange,
                              ),
                                new Text(
                                  "I have a good idea, but things could change",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],)),
                          new Padding(
                              padding: EdgeInsets.only(left: 0, right: 0),
                              child: Row(children: <Widget>[Radio(
                                value: 2,
                                groupValue: _certaintyValue,
                                onChanged: _handleExperienceValueChange,
                              ),
                                new Text(
                                  "Its something I\'m interested in, but who knows",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],)),
                          new Padding(
                              padding: EdgeInsets.only(left: 0, right: 0),
                              child: Row(children: <Widget>[Radio(
                                value: 3,
                                groupValue: _certaintyValue,
                                onChanged: _handleExperienceValueChange,
                              ),
                                new Text(
                                  "I have no clue what I want to do",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  onSave(){
    var certainty;
    if(_certaintyValue == 0){
      certainty = "certain";
    }
    if(_certaintyValue == 1){
      certainty = "mostly certain";
    }
    if(_certaintyValue == 2){
      certainty = "just interested";
    }

    if(_certaintyValue == 3){
      certainty = "no clue";
    }

    Navigator.pop(context, certainty);
  }

  void _handleExperienceValueChange(int value) {
    setState(() {
      _certaintyValue = value;

      switch (_certaintyValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
        case 3:
          break;
      }
    });
  }
}
