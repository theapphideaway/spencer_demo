import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Model/Mentee.dart';
import 'Model/Mentor.dart';
import 'Profile.dart';

class SearchUsers extends StatefulWidget {
  final bool isMentee;
  SearchUsers({Key key, @required this.isMentee});
  SearchUsersState createState() => SearchUsersState(isMentee);
}


class SearchUsersState extends State<SearchUsers> {
  bool isMentee;
  bool isLoading = true;
  bool isProfileSelected = false;
  int globalIndex = 0;
  var picture;
  String tableName;
  List<Mentor> mentors = new List<Mentor>();
  List<Mentee> mentees = new List<Mentee>();
  TextEditingController textController = new TextEditingController();

  SearchUsersState(bool isMentee){
    this.isMentee = isMentee;
    if(isMentee) tableName = "Mentors";
    else tableName = "Mentees";
    searchUser();
  }



  var europeanCountries = ['Albania', 'Andorra', 'Armenia', 'Austria',
    'Azerbaijan', 'Belarus', 'Belgium', 'Bosnia and Herzegovina', 'Bulgaria',
    'Croatia', 'Cyprus', 'Czech Republic', 'Denmark', 'Estonia', 'Finland',
    'France', 'Georgia', 'Germany', 'Greece', 'Hungary', 'Iceland', 'Ireland',
    'Italy', 'Kazakhstan', 'Kosovo', 'Latvia', 'Liechtenstein', 'Lithuania',
    'Luxembourg', 'Macedonia', 'Malta', 'Moldova', 'Monaco', 'Montenegro',
    'Netherlands', 'Norway', 'Poland', 'Portugal', 'Romania', 'Russia',
    'San Marino', 'Serbia', 'Slovakia', 'Slovenia', 'Spain', 'Sweden',
    'Switzerland', 'Turkey', 'Ukraine', 'United Kingdom', 'Vatican City'];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black.withOpacity(0.30),
      body: isLoading
          ? Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Colors.blue[800]),
          ),
        ),
      )
          : SingleChildScrollView(child: Padding(
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
                ],),
                Padding(padding: EdgeInsets.all(16),
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(border: InputBorder.none, hintText: "Search For First Names Only"),
                    )),

                !isProfileSelected? Container(
                    height: 700,
                    child: ListView.builder(
                      itemCount: !isMentee? mentees.length: mentors.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: ()=>setState((){
                            globalIndex = index;
                            isProfileSelected = true;
                          }),
                          title: Text(!isMentee? mentees[index].FirstName + " " +mentees[index].LastName:
                          mentors[index].FirstName + " " +mentors[index].LastName),
                        );
                      },
                    )): Container(
                  height: 700,
                    child: !isMentee? Profile(isMentee: isMentee,isGuest: true, mentee: mentees[globalIndex]):
                    Profile(isMentee: isMentee,isGuest: true, mentor: mentors[globalIndex]))
              ],
            ),),
      ),
    ));
  }

  searchUser()async {
    Map<dynamic, dynamic> temps;
    var userResponse =
    await FirebaseDatabase.instance.reference().child(tableName);
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
          if (key == "first_name" && value != null) person.FirstName = value;
          if (key == "last_name"&& value != null) person.LastName = value;
        });
        if (!isMentee&& person.FirstName != null) mentees.add(person);
        if(isMentee && person.FirstName != null) mentors.add(person);
      }),
      setState((){
        isLoading = false;
      })
    });
  }

  selectUser()async {
    await Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Profile(isMentee: isMentee,);
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
