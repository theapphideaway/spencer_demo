import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart' as prefix0;
import 'package:way_ahead/CommentPage.dart';

import 'Model/Mentee.dart';
import 'Model/Mentor.dart';
import 'Model/Post.dart';
import 'NewPost.dart';
import 'Profile.dart';

class Feed extends StatefulWidget {
  final bool isMentee;

  Feed({Key key, @required this.isMentee});
  FeedState createState() => FeedState(isMentee);
}

class FeedState extends State<Feed> with TickerProviderStateMixin {
  var profilePictureUrl;
  var profileBytes;
  var startFade = 0.0;
  var endFade = 1.0;

  double searchWidth = 40;
  double searchHeight = 40;
  bool isMentee;
  bool isLoading = true;
  bool isSearching = false;
  bool isPictureVisible = true;
  bool isSearchLoading = true;
  String industry;
  String userId;
  String name;
  var mentee = new Mentee();
  var mentor = new Mentor();
  List<Post> posts = new List<Post>();
  AnimationController animationController;
  Animation<double> animation;
  int globalIndex = 0;
  var picture;
  var pictures = List<Uint8List>();
  String tableName;
  List<Mentor> mentors = new List<Mentor>();
  List<Mentee> mentees = new List<Mentee>();
  TextEditingController searchController = new TextEditingController();

  FeedState(bool isMentee) {
    this.isMentee = isMentee;
    getUser();
    getPosts();
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() => setState(() {}));


    searchController.addListener((){
      isSearchLoading = true;
      setState(() {
        isSearchLoading = true;
        searchUsers();
        if(searchController.text == ""){
          getUsers();
        }
      });
    });
    animation = Tween<double>(
      begin: !isSearching?0.0: 1.0,
      end: !isSearching?1.0: 0.0,
    ).animate(animationController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: isLoading
              ? Center(
                  child: Container(
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.blue[800]),
                    ),
                  ),
                ))
              : SingleChildScrollView(
                  child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Visibility(
                          visible: isSearching,
                          child: FlatButton(
                            onPressed: search,
                              child: Text("Cancel", style: TextStyle(fontSize: 18),))
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 32),
                              child: Visibility(
                                visible: isPictureVisible,
                                  child: Image.asset(
                                'assets/wayaheadLogo.png',
                                height: 40,
                              )),
                        ),
                        Expanded(
                          child: Container(),
                        ),

                        GestureDetector(
                            onTap: search,
                            child: Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: AnimatedSize(
                                  vsync: this,
                                  duration: Duration(milliseconds: 200),
                                  child: Container(
                                      width: searchWidth,
                                      height: searchHeight,
                                      child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: !isSearching
                                              ? Icon(Icons.search, size: 30)
                                              : Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8),
                                                  child: TextField(
                                                    controller: searchController,
                                                    style:
                                                        TextStyle(fontSize: 22),
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 15,
                                                                bottom: 0,
                                                                top: 0,
                                                                right: 15),
                                                        hintText: "Search"),
                                                  ))),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.grey[350],
                                      )),
                                ))),
                      ],
                    ),

                    Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
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
                                            'assets/DefaultProfilePicture.png',
                                            width: 40,
                                            height: 40,
                                          )),
                                Expanded(child: GestureDetector(
                                  onTap: preparePost,
                                  child: Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                    child: Text(
                                      "Whats on your mind? ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),)

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
                                                  GestureDetector(
                                                    onTap: ()=> goToProfile(posts[index].userId, posts[index].isMentee),
                                                    child: Row(
                                                    children: <Widget>[
                                                      posts[index].picture !=
                                                              null
                                                          ? Container(
                                                              height: 45,
                                                              width: 45,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30),
                                                                      image:
                                                                          DecorationImage(
                                                                        image:
                                                                            MemoryImage(
                                                                          posts[index]
                                                                              .picture,
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
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 8),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            posts[index].name !=
                                                                    null
                                                                ? posts[index]
                                                                    .name
                                                                : "",
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0,
                                                            vertical: 16),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        posts[index].content !=
                                                                null
                                                            ? posts[index]
                                                                .content
                                                            : "",
                                                        style: TextStyle(
                                                            fontSize: 24),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: ()=>goToCommentPage(posts[index]),
                                                    child: Row(children: <Widget>[
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                                        child: Icon(Icons.message, color: Colors.blue[800],),
                                                      ),
                                                      Text("Comment", style: TextStyle(color: Colors.blue[800],
                                                          fontSize: 18),)
                                                    ],)
                                                  ),

                                                ],
                                              )));
                                    }))
                          ],
                        ),
                        Visibility(
                          visible: isSearching,
                        child: Positioned.fill(child: AnimatedOpacity(
                          opacity: !isSearching?0.0: 1.0,
    duration: Duration(milliseconds: 200),
                          child: Container(
                            color: Colors.white,
                            child: Scaffold(
                              body: isSearchLoading
                                  ? Container(
                                color: Colors.white,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: new AlwaysStoppedAnimation<Color>(
                                        Colors.blue[800]),
                                  ),
                                ),
                              )
                                  : Padding(
                                padding: EdgeInsets.only(top: 0),
                                child: Column(
                                  children: <Widget>[Expanded(child: ListView.builder(
                                        itemCount: !isMentee? mentees.length: mentors.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                              onTap: ()=> {globalIndex = index,
                                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                !isMentee? Profile(isMentee: isMentee,isGuest: true, mentee: mentees[globalIndex], isGuestMentee: !isMentee,):
                                                Profile(isMentee: isMentee,isGuest: true, mentor: mentors[globalIndex], isGuestMentee: !isMentee,)))},
                                              child: Card(
                                                  child: Padding(
                                                      padding: EdgeInsets.all(16),
                                                      child:Row(children: <Widget>[
                                                        Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: 16),
                                                            child:Container(
                                                                height: 45,
                                                                width: 45,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius.circular(30),
                                                                    image: DecorationImage(
                                                                      image: MemoryImage(!isMentee? mentees[index].ProfilePicture: mentors[index].ProfilePicture
                                                                      ),
                                                                      fit: BoxFit.cover,
                                                                    )))
//                                                                : Container(
//                                                                height: 45,
//                                                                width: 45,
//                                                                decoration: BoxDecoration(
//                                                                    borderRadius:
//                                                                    BorderRadius.circular(
//                                                                        30),
//                                                                    image: DecorationImage(
//                                                                      image: AssetImage(
//                                                                        'assets/DefaultProfilePicture.png',
//                                                                      ),
//                                                                      fit: BoxFit.cover,
//                                                                    )))
                                              ),
                                                        Text(!isMentee? mentees[index].FirstName + " " +mentees[index].LastName:
                                                        mentors[index].FirstName + " " +mentors[index].LastName, style: TextStyle(fontSize: 18),),

                                                      ]))));

                                        },
                                      ))
                                  ],
                                ),),
                              ),
                            )
                          ),)
                        ),
                      ],
                    )
                  ],
                ))),
    );
  }

  goToCommentPage(Post post){

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CommentPage(post: post,
              userPicture: profileBytes.toString(),
              isMentee: isMentee, )
                ));
  }


  goToProfile(String id, String isProfileMentee)async {
    bool profileMentee = isProfileMentee == "true";

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => profileMentee
                ? Profile(
                isMentee: isMentee, isGuest: true, mentee: mentee, isGuestMentee: profileMentee,)
                : Profile(
                isMentee: isMentee,
                isGuest: true,
                mentor: mentor,
            isGuestMentee: profileMentee,)));
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
          picture: profileBytes, id: userId,
          isMentee: isMentee,
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

    if (onReload == true) {
      setState(() {
        isLoading = true;
      });
      getUser();
      getPosts();
    }
  }

  getPosts() async {
    Map<dynamic, dynamic> temps;
    posts = new List<Post>();
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
              if (key == "post_id") post.postId = value.toString();
              if (key == "name") post.name = value;
              if (key == "content") post.content = value;
              if (key == "user_id") post.userId = value;
              if (key == "isMentee") post.isMentee = value.toString();
              if (key == "user_picture") {
                post.picture = base64Decode(value.toString());
              }
            });
            posts.add(post);
          }),
        });
  }

  Future < void > showAfter() async {
    await Future.delayed(Duration(milliseconds: 300), () {
      print('delay completed');
    });
    setState(() {
      isPictureVisible = true;
    });
  }

  search() async {
    setState(() {
      if (searchWidth == 40) {
        searchWidth = 260;
      } else {
        searchWidth = 40;
      }
      isSearching = !isSearching;

      if(isSearching){
        isPictureVisible = false;
        getUsers();
      } else{
        showAfter();
      }


    });
  }

  getUsers()async {
    mentors = new List<Mentor>();
    mentees = new List<Mentee>();
    var searchTableName;
    if(isMentee) searchTableName = "Mentors";
    else searchTableName = "Mentees";
    Map<dynamic, dynamic> temps;
    var userResponse =
    await FirebaseDatabase.instance.reference().child(searchTableName);
    userResponse.once().then((snapshot) => {
      print(snapshot.value),
      temps = snapshot.value,
      temps.forEach((key, value) {
        var person;
        if (!isMentee) person = new Mentee();
        else person = new Mentor();
        print(key);
        person.Key = key;
        value.forEach((key, value) {
          print(value);
          var picture;
          if (key == "first_name" && value != null) person.FirstName = value;
          if (key == "last_name"&& value != null) person.LastName = value;
          if (key == "profile_picture"&& value != null){
            picture = base64Decode(value.toString());
            person.ProfilePicture = picture;
          };
        });
        if (!isMentee&& person.FirstName != null) mentees.add(person);
        if(isMentee && person.FirstName != null) mentors.add(person);
      }),

    }).then((_){
      setState((){
        isSearchLoading = false;
      });
    });
  }

  searchUsers(){
    isSearchLoading = true;
    var newMentees = new List<Mentee>();
    var newMentors = new List<Mentor>();
    if(!isMentee ){
      for(var mentee in mentees){
        var name  = mentee.FirstName.toLowerCase() + " " + mentee.LastName.toLowerCase();
        if (name.contains(searchController.text.toLowerCase())){
          newMentees.add(mentee);
        }
      }
      setState(() {
        mentees = newMentees;
        isSearchLoading = false;
      });
    } else{
      for(var mentor in mentors){
        var name  = mentor.FirstName.toLowerCase() + " " + mentor.LastName.toLowerCase();
        if (name.contains(searchController.text.toLowerCase())){
          newMentors.add(mentor);
        }
      }
      setState(() {
        mentors = newMentors;
        isSearchLoading = false;
      });
    }
  }
}
