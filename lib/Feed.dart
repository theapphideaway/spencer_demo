import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:way_ahead/SearchUsers.dart';

import 'Model/Post.dart';
import 'NewPost.dart';

class Feed extends StatefulWidget {
  final bool isMentee;
  Feed({Key key, @required this.isMentee});
  FeedState createState() => FeedState(isMentee);
}

class FeedState extends State<Feed> {
  var profilePictureUrl;
  var profileBytes;
  bool isMentee;
  bool isLoading = true;
  String industry;
  String userId;
  String name;
  List<Post> posts = new List<Post>();

  FeedState(bool isMentee) {
    this.isMentee = isMentee;
    getUser();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: isLoading
                  ? Center(child: Container(
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.blue[800]),
                        ),
                      ),
                    ))
                  : SingleChildScrollView(
              child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 32),
                              child: Image.asset(
                                'assets/wayaheadLogo.png',
                                height: 40,
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            GestureDetector(
                              onTap: search,
                                child:
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
                                )))
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: profilePictureUrl != null
                                    ? Container(
                                        height: 45,
                                        width: 45,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
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
                            GestureDetector(
                              onTap: preparePost,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: Text(
                                  "Whats on your mind? ",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(0),
                          child: new Row(
                            children: <Widget>[
                              new Expanded(
                                child: new Padding(
                                    padding:
                                        EdgeInsets.only(left: 16, right: 8),
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
                                    padding:
                                        EdgeInsets.only(left: 8, right: 16),
                                    child: Divider(
                                      color: Colors.grey,
                                    )),
                              )
                            ],
                          ),
                        ),
                        Container(
                            height: 600,
                            child: ListView.builder(
                                itemCount: posts.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 16,
                                              top: 8,
                                              left: 16,
                                              bottom: 24),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  posts[index].picture != null
                                                      ? Container(
                                                          height: 45,
                                                          width: 45,
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                  image:
                                                                      DecorationImage(
                                                                    image:
                                                                        MemoryImage(
                                                                          posts[index].picture,
                                                                    ),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )))
                                                      : Image.asset(
                                                          'assets/default_profile_picture.jpg',
                                                          width: 40,
                                                          height: 40,
                                                        ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.symmetric(horizontal: 8),
                                                    child: Align(
                                                      alignment:
                                                      Alignment.centerLeft,
                                                      child: Text(
                                                        posts[index].name != null
                                                            ? posts[index].name
                                                            : "",
                                                        style:
                                                        TextStyle(fontSize: 18),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              Padding(
                                                padding:
                                                EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                                                child: Align(
                                                  alignment:
                                                  Alignment.centerLeft,
                                                  child: Text(
                                                    posts[index].content != null
                                                        ? posts[index].content
                                                        : "",
                                                    style:
                                                    TextStyle(fontSize: 24),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )));
                                }))
                      ],
                    ))),
    );
  }

  getUser() async {
    try {
      await FirebaseAuth.instance.currentUser().then((user) => {
            userId = user.uid,
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

  getMentee(String id) async {
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
              setState(() {
                isLoading = false;
                profileBytes = temp;
                profilePictureUrl = finalTempString;
              }),
            }
          else
            {
              profilePictureUrl = null,
              setState(() {
                isLoading = false;
              })
            },
        });
  }

  getMentor(String id) async {
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
              setState(() {
                profileBytes = temp;
                profilePictureUrl = finalTempString;
                isLoading = false;
              })
            }
          else
            {profilePictureUrl = null},
        });
  }

  preparePost() async {
    var firstName;
    var lastName;
    var tableName;
    var lastNameResponse;
    if (isMentee) {
      tableName = "Mentees";
    } else {
      tableName = "Mentors";
    }

    var firstNameResponse = await FirebaseDatabase.instance
        .reference()
        .child(tableName)
        .child(userId)
        .child("first_name");
    firstNameResponse.once().then((snapshot) => {
          print(snapshot.value),
          firstName = snapshot.value,
        });
    lastNameResponse = await FirebaseDatabase.instance
        .reference()
        .child(tableName)
        .child(userId)
        .child("last_name");
    lastNameResponse.once().then((snapshot) => {
          print(snapshot.value),
          lastName = snapshot.value,
          createPost(firstName, lastName)
        });
  }

  createPost(String firstName, String lastName) async {
    final onReload = await Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return NewPost(
          name: firstName + " " + lastName,
          picture: profileBytes,
        );
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    ));

    if(onReload == true){
      setState(() {
        isLoading = true;
      });
      getUser();
      getPosts();

    }
  }

  getPosts() async {
    Map<dynamic, dynamic> temps;
    Post post = new Post();
    var bioResponse =
        await FirebaseDatabase.instance.reference().child("Posts");
    bioResponse.once().then((snapshot) => {
          print(snapshot.value),
          temps = snapshot.value,
          temps.forEach((key, value) {
            Post post = new Post();
            print(key);
            value.forEach((key, value) {
              print(value);
              if (key == "name") post.name = value;
              if (key == "content") post.content = value;
              if (key == "user_picture") {
                post.picture = base64Decode(value.toString());
              }
            });
            posts.add(post);
          }),
        });
  }


  search()async {
    await Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SearchUsers(isMentee: isMentee,);
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    ));
  }
}
