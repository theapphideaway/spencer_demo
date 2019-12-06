import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:way_ahead/CreateMentee.dart';
import 'package:way_ahead/CreateMentor.dart';
import 'package:way_ahead/Services/FirebaseProvider.dart';

import 'Model/Mentee.dart';
import 'Model/Mentor.dart';
import 'Services/FirebaseProvider.dart';

class SignUp extends StatefulWidget {
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  var profilePicture;
  int _radioValue = 0;
  bool isLoading = false;
  Mentor mentor = new Mentor();
  Mentee mentee = new Mentee();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: !isLoading? SingleChildScrollView(
                child: Container(
                    child: Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: GestureDetector(
                onTap: () => {Navigator.pop(context)},
                child: Icon(
                  Icons.clear,
                  size: 32,
                ),
              )),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 32),
            child: Text(
              "Sign Up",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
        ),


        Padding(
          padding: EdgeInsets.only(bottom: 32),
          child: GestureDetector(
            onTap: getProfilePicture,
              child: Container(
              child: Stack(children: <Widget>[
            Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(
                        100),
                    image: DecorationImage(
                      image: profilePicture == null?AssetImage(
                        'assets/DefaultProfilePicture.png',
                      ): FileImage(profilePicture),
                      fit: BoxFit.cover,
                    ))),
                  Positioned(
                    bottom: 7,
                    right: 7,
                    child: Container(decoration: BoxDecoration(
                      color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(
                            100),),
                      child: Icon(Icons.camera_alt, size: 35,),),
                  )

          ],))),

        ),
        new Row(
          children: <Widget>[
            new Expanded(
              child: new Padding(
                  padding: EdgeInsets.only(left: 16, right: 8),
                  child: Divider(
                    color: Colors.black,
                  )),
            ),
            new Text(
              "WHAT DO YOU WANT TO BE?",
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
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0),
          child: new Row(
            children: <Widget>[
              new Padding(
                  padding: EdgeInsets.only(left: 0, right: 0),
                  child: Radio(
                    value: 0,
                    groupValue: _radioValue,
                    onChanged: _handleRadioValueChange,
                  )),
              new Text(
                "I want to ",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              new Text(
                "find a Mentor",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(vertical: 0),
          child: new Row(
            children: <Widget>[
              new Padding(
                  padding: EdgeInsets.only(left: 0, right: 0),
                  child: Radio(
                    value: 1,
                    groupValue: _radioValue,
                    onChanged: _handleRadioValueChange,
                  )),
              new Text(
                "I want to ",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              new Text(
                "be a Mentor",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        new Row(
          children: <Widget>[
            new Expanded(
              child: new Padding(
                  padding: EdgeInsets.only(left: 16, right: 8),
                  child: Divider(
                    color: Colors.black,
                  )),
            ),
            new Text(
              "SIGN UP USING ",
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
        new Row(
          children: <Widget>[
            new Expanded(child: Container()),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: GestureDetector(
                  child: Image.asset('assets/GoogleButton.png', scale: 1.2),
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: GestureDetector(
                  child: Image.asset('assets/FacebookButton.png', scale: 1.2)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: GestureDetector(
                  child: Image.asset(
                'assets/Twitter.png',
                scale: 1.2,
              )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: GestureDetector(
                  child: Image.asset('assets/LinkedinButton.png', scale: 1.2)),
            ),
            new Expanded(child: Container())
          ],
        ),
        new Row(
          children: <Widget>[
            new Expanded(
              child: new Padding(
                  padding: EdgeInsets.only(left: 16, right: 8),
                  child: Divider(
                    color: Colors.black,
                  )),
            ),
            new Text(
              "SIGN UP USING EMAIL",
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
        Padding(
          padding: EdgeInsets.only(
            left: 16,
            top: 32,
            right: 16,
          ),
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16),
                hintText: "Email",
                border: OutlineInputBorder()),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(16),
              hintText: "Password",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 16, top: 0, left: 16, bottom: 16),
          child: TextField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(16),
              hintText: "Confirm Password",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        new Container(
          width: double.infinity,
          child: new Padding(
            padding: EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 32),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              padding: EdgeInsets.all(16),
              color: Colors.blue[800],
              onPressed: startQuestionaire,
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 32),
            child: new Row(
          children: <Widget>[
            Expanded(child: Container()),
            new Text(
              "Already have an account? ",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            new GestureDetector(
              onTap: () => {Navigator.pop(context)},
              child: Text(
                "Login",
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(child: Container()),
          ],
        ))

      ],
    ))): Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue[800]),
        ),
      ),
    )));
  }

  startQuestionaire()async {
    setState(() {
      isLoading = true;
    });
    if(confirmPasswordController.text == passwordController.text) {
      if (_radioValue == 0) {
        if (emailController.text != null && passwordController.text != null) {
          await FirebaseProvider.firebaseProvider.signUp(
              emailController.text, passwordController.text).then((id){
                mentee.Id = id;
            addProfilePicture(mentee.Id, "Mentees", mentee);
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => CreateMentee(mentee: mentee)));
            isLoading = false;
          });


        }
      } else {
        if (emailController.text != null && passwordController.text != null) {
          await FirebaseProvider.firebaseProvider.signUp(
              emailController.text, passwordController.text).then((id){
                mentor.id = id;
                addProfilePicture(mentee.Id, "Mentees", null, mentor);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => CreateMentor(mentor: mentor,)));
                isLoading = false;
          });

        }
      }
    } else{
      final snackBar = SnackBar(
      content: Text('Passwords must match', style: TextStyle(fontSize: 18),),
    );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  getProfilePicture() async {
      profilePicture = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  Future addProfilePicture(String id, String tableName,[Mentee mentee, Mentor mentor]) async {
    var imageBytes = profilePicture.readAsBytesSync();
    if(mentee != null) mentee.ProfilePicture = await base64Encode(imageBytes);
    if(mentor != null)mentor.ProfilePicture = await base64Encode(imageBytes);

  }
}
