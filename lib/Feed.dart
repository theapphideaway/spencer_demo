import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  final bool isMentee;
  Feed({Key key, @required this.isMentee});
  FeedState createState() => FeedState(isMentee);
}

class FeedState extends State<Feed> {
  var profilePictureUrl;
  bool isMentee;
  bool isLoading = true;

  FeedState(bool isMentee){
    this.isMentee = isMentee;
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: isLoading
                  ? Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor:
                    new AlwaysStoppedAnimation<Color>(Colors.blue[800]),
                  ),
                ),
              )
                  : Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Image.asset(
                  'assets/wayaheadLogo.png',
                  height: 40,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Container(
                    child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.search, size: 30)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[350],
                    ),
                  ))
            ],
          ),
        Row(children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          child: profilePictureUrl != null
              ? Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(
                      30),
                  image: DecorationImage(
                    image: MemoryImage(
                      profilePictureUrl,
                    ),
                    fit: BoxFit.cover,
                  )))
              : Image.asset(
            'assets/default_profile_picture.jpg',
            width: 40,
            height: 40,
          )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Text("Whats on your mind? ", style: TextStyle(fontSize: 16),),
          )
        ],),


          Padding(
            padding: EdgeInsets.all(16),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                      padding: EdgeInsets.only(left: 16, right: 8),
                      child: Divider(
                        color: Colors.grey,
                      )),
                ),
                new Text(
                  "Posts",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                new Expanded(
                  child: new Padding(
                      padding: EdgeInsets.only(left: 8, right: 16),
                      child: Divider(
                        color: Colors.grey,
                      )),
                )
              ],
            ),
          ),



        ],
      ))),
    );
  }

  getUser() async {
    try {
      await FirebaseAuth.instance.currentUser().then((user) => {
        if (user == null)
          {
            setState(() {
              isLoading = false;
            })
          }
        else
          {
            if (isMentee)
              {
                getMentee(user.uid),
              }
            else
              {
                getMentor(user.uid),
              }
          }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  getMentee(String id)async {
    var temp;
    var finalTempString;
    var pictureResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentees")
        .child(id)
        .child("profile_picture");
    pictureResponse.once().then((snapshot) => {
      print(snapshot.value),
      temp = snapshot.value,
      if (temp.toString().length > 200)
        {
          finalTempString = base64Decode(temp.toString()),
          setState((){
            isLoading = false;
            profilePictureUrl = finalTempString;
          }),
        }
      else
        {profilePictureUrl = null,
        setState((){
          isLoading = false;
        })},
    });
  }

  getMentor(String id)async {
    var temp;
    var finalTempString;
    var pictureResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentors")
        .child(id)
        .child("profile_picture");
    pictureResponse.once().then((snapshot) => {
      print(snapshot.value),
      temp = snapshot.value,
      if (temp.toString().length > 200)
        {
          finalTempString = base64Decode(temp.toString()),
          setState((){
            profilePictureUrl = finalTempString;
            isLoading = false;
          })
        }
      else
        {profilePictureUrl = null},
    });
  }
}
