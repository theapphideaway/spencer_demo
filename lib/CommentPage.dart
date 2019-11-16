import 'dart:convert';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:way_ahead/Services/FirebaseProvider.dart';

import 'Model/Post.dart';

class CommentPage extends StatefulWidget {
  final Post post;
  final String userPicture;
  final bool isMentee;
  final String name;
  CommentPage(
      {Key key,
      @required this.post,
      @required this.userPicture,
      @required this.isMentee,
      @required this.name});
  CommentPageState createState() =>
      CommentPageState(post, name, userPicture, isMentee);
}

class CommentPageState extends State<CommentPage> {
  TextEditingController commentController = new TextEditingController();
  Post post;
  String name;
  String userPicture;
  bool isMentee;
  List<Post> comments = new List<Post>();

  CommentPageState(Post post, String name, String userPicture, bool isMentee) {
    this.post = post;
    this.name = name;
    this.userPicture = userPicture;
    this.isMentee = isMentee;
  }

  @override
  void initState() {
    getComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          brightness: Brightness.light,
          iconTheme: IconThemeData(
            color: Colors.blue[800], //change your color here
          ),
          title: Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: post.picture != null
                      ? Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                image: MemoryImage(
                                  post.picture,
                                ),
                                fit: BoxFit.cover,
                              )))
                      : Image.asset(
                          'assets/DefaultProfilePicture.png',
                          width: 40,
                          height: 40,
                        )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Text(
                  post.name,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                  padding:
                      EdgeInsets.only(right: 16, left: 16, top: 32, bottom: 16),
                  child: Text(
                    post.content,
                    style: TextStyle(fontSize: 24),
                  )),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(
                      Icons.message,
                      color: Colors.blue[800],
                    ),
                  ),
                  Text(
                    "Comment",
                    style: TextStyle(color: Colors.blue[800], fontSize: 18),
                  )
                ],
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Divider(
                    color: Colors.grey,
                  )),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.only(
                          right: 16, top: 8, left: 16, bottom: 24),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            child: Row(children: <Widget>[
                              comments[index].picture != null
                                  ? Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          image: DecorationImage(
                                            image: MemoryImage(
                                              comments[index].picture,
                                            ),
                                            fit: BoxFit.cover,
                                          )))
                                  : Image.asset(
                                      'assets/default_profile_picture.jpg',
                                      width: 40,
                                      height: 40,
                                    ),
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.grey[300],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              comments[index].name != null
                                                  ? comments[index].name
                                                  : "",
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(children: <Widget>[
                                          Text(
                                            comments[index].content != null
                                                ? comments[index].content
                                                : "",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ])
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                            ]),
                          ),
                        ],
                      ));
                },
              )),
              Container(
                height: 50,
                child: Row(
                  children: <Widget>[
                    Flexible(
                        child: TextField(
                          textCapitalization: TextCapitalization.sentences,
                      controller: commentController,
                      decoration: InputDecoration(
                          hintText: "Write a Comment...",
                          focusColor: Colors.blue[800]),
                    )),
                    GestureDetector(
                        onTap: addComment,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Icon(Icons.send, color: Colors.blue[800]),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  getComments() async {
    comments = new List<Post>();
    var firstNameResponse = FirebaseDatabase.instance
        .reference()
        .child("Posts")
        .child(post.postId)
        .child("comments");
    await firstNameResponse.once().then((snapshot) => {
          print(snapshot.value),
          snapshot.value.forEach((key, value) {
            Post post = new Post();
            print(key);
            value.forEach((key, value) {
              print(value);
              if (key == "id") post.postId = value.toString();
              if (key == "name") post.name = value;
              if (key == "content") post.content = value;
              if (key == "isMentee") post.isMentee = value.toString();
              if (key == "user_picture") {
                post.picture = base64Decode(value.toString());
              }
            });
            comments.add(post);
          }),
        });
    setState(() {});
  }

  addComment() async {
    var random = Random.secure();
    var value = random.nextInt(1000000000);
    await FirebaseProvider.firebaseProvider.getUserId().then((id) {
      try {
        FirebaseDatabase.instance
            .reference()
            .child("Posts")
            .child(post.postId)
            .child("comments")
            .child(value.toString())
            .set({
          "content": commentController.text,
          "name": post.name,
          "user_picture": userPicture,
          "id": id,
          "isMentee": isMentee
        });
      } catch (e) {
        print(e);
      }
    });
    FocusScope.of(context).requestFocus(new FocusNode());
    commentController.text = "";
    getComments();
  }
}
