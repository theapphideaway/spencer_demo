import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MentorEducation extends StatefulWidget {
  MentorEducationState createState() => MentorEducationState();
}

const educationTypes = [
  "High School/GED",
  "Some College",
  "Associates",
  "Bachelors",
  "Masters",
  "Doctorate"
];

class MentorEducationState extends State<MentorEducation> {
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
                new Align(
                  alignment: Alignment.topRight,
                  child: FlatButton(
                      onPressed: () => {Navigator.pop(context)},
                      child: Icon(Icons.clear)),
                ),
                Expanded(
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView.builder(
                      itemCount: educationTypes.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            onTap: () =>
                            {Navigator.pop(context, educationTypes[index])},
                            title: Text(educationTypes[index]));
                      },
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
