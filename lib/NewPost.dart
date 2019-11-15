import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:way_ahead/Services/FirebaseProvider.dart';

class NewPost extends StatefulWidget {
  final String name;
  final bool isMentee;
  final String id;
  final dynamic picture;
  NewPost({Key key, @required this.name, @required this.picture,
    @required this.id, @required this.isMentee});
  NewPostState createState() => NewPostState(name, picture, id, isMentee);

}


class NewPostState extends State<NewPost> {
  String name;
  String id;
  var picture;
  bool isMentee;
  TextEditingController textController = new TextEditingController();

  NewPostState(String name, var picture, String id, bool isMentee){
    this.name = name;
    this.id = id;
    this.picture = picture;
    this.isMentee = isMentee;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black.withOpacity(0.30),
      body: Padding(
        padding: EdgeInsets.only(top: 80),
        child: Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0))),
            child: Container(
                color: Colors.white,
                child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  FlatButton(
                      onPressed: () => {Navigator.pop(context)},
                      child: Icon(Icons.clear)),
                  Expanded(child: Container(),),
                  FlatButton(
                      onPressed: ()=>sendPost(),
                      child: Text("Post", style: TextStyle(fontSize: 18, color: Colors.blue[800]),)),
                ],),
                Padding(padding: EdgeInsets.all(16),
                child: TextField(
                  minLines: 10,
                  maxLines: 20,
                  keyboardType: TextInputType.multiline,
                  controller: textController,
                  decoration: InputDecoration(border: InputBorder.none,
                      hintText: "Whats on your mind?",
                  ),
                ))


              ],
            ))),
      ),
    );
  }

  sendPost()async {
    var random = Random.secure();
    var value = random.nextInt(1000000000);

    await FirebaseDatabase.instance
        .reference()
        .child("Posts")
        .child(value.toString()).
        set({"content": textController.text,
      "name": name,
      "user_picture": picture.toString(),
      "id": id,
      "isMentee": isMentee
    });
    Navigator.pop(context, true);
  }
}
