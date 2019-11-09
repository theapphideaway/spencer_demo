import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MentorExperience extends StatefulWidget {
  MentorExperienceState createState() => MentorExperienceState();
}

class MentorExperienceState extends State<MentorExperience> {
  int _experienceValue = 0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black.withOpacity(0.30),
      body: Padding(
        padding: EdgeInsets.only(top: 600),
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
                          "How many years experience do you have?",
                          style: TextStyle(fontSize: 16),
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: new Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(),
                          ),
                          new Padding(
                              padding: EdgeInsets.only(left: 0, right: 0),
                              child: Radio(
                                value: 0,
                                groupValue: _experienceValue,
                                onChanged: _handleExperienceValueChange,
                              )),
                          new Text(
                            "1-4",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          new Padding(
                              padding: EdgeInsets.only(left: 0, right: 0),
                              child: Radio(
                                value: 1,
                                groupValue: _experienceValue,
                                onChanged: _handleExperienceValueChange,
                              )),
                          new Text(
                            "5-9",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          new Padding(
                              padding: EdgeInsets.only(left: 0, right: 0),
                              child: Radio(
                                value: 2,
                                groupValue: _experienceValue,
                                onChanged: _handleExperienceValueChange,
                              )),
                          new Text(
                            "10+",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
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
    var experience;
    if(_experienceValue == 0){
      experience = "1-4";
    }
    if(_experienceValue == 1){
      experience = "5-9";
    }
    if(_experienceValue == 2){
      experience = "10+";
    }

    Navigator.pop(context, experience);
  }

  void _handleExperienceValueChange(int value) {
    setState(() {
      _experienceValue = value;

      switch (_experienceValue) {
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
