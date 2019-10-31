import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SignUp.dart';

class CreateMentee extends StatefulWidget {
  CreateMenteeState createState() => CreateMenteeState();
}

class CreateMenteeState extends State<CreateMentee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 16, top: 64, right: 16, ),
          child: Image.asset('assets/MenteeIcon.png'),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Text(
                  "Create ",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Mentee Profile",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            )),
        Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16),
                hintText: "First Name",
                border: OutlineInputBorder()),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 16,
            top: 16,
            right: 16,
          ),
          child: TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16),
                hintText: "Last Name",
                border: OutlineInputBorder()),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(16),
              hintText: "Phone Number",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                    padding: EdgeInsets.only(left: 16, right: 8),
                    child: Divider(
                      color: Colors.black,
                    )),
              ),
              new Text(
                "TELL US A LITTLE ABOUT YOURSELF",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              new Expanded(
                child: new Padding(
                    padding: EdgeInsets.only(left: 8, right: 16),
                    child: Divider(
                      color: Colors.black,
                    )),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(16),
              hintText: "Write your bio here...",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.multiline,
            maxLines: 100,
            minLines: 5,
          ),
        ),
        new Container(
          width: double.infinity,
          child: new Padding(
            padding: EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 12),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              padding: EdgeInsets.all(16),
              color: Colors.indigoAccent,
              onPressed: () => {},
              child: Text(
                "Continue",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          padding: EdgeInsets.all(16),
          color: Colors.transparent,
          onPressed: () => {Navigator.pop(context)},
          child: Text(
            "Cancel",
            style: TextStyle(
              fontSize: 18,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    )))));
  }

  onSignUp() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }
}
