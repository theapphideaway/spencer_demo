import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewPost extends StatefulWidget {
  final String name;
  final dynamic picture;
  NewPost({Key key, @required this.name, @required this.picture});
  NewPostState createState() => NewPostState(name, picture);
}


class NewPostState extends State<NewPost> {
  String name;
  var picture;
  TextEditingController textController = new TextEditingController();

  NewPostState(String name, var picture){
    this.name = name;
    this.picture = picture;
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
                  keyboardType: TextInputType.multiline,
                  controller: textController,
                  decoration: InputDecoration(border: InputBorder.none,
                      hintText: "Whats on your mind?",
                  ),
                ))


              ],
            )),
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
      "user_picture": picture.toString()
    });
    Navigator.pop(context);
  }
}
