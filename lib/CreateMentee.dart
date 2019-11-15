
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MenteeQuestionaire.dart';
import 'Model/Mentee.dart';
import 'SignUp.dart';

class CreateMentee extends StatefulWidget {
  final Mentee mentee;
  CreateMentee({Key key, @required this.mentee});
  CreateMenteeState createState() => CreateMenteeState(mentee);
}

class CreateMenteeState extends State<CreateMentee> {
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController bioController = new TextEditingController();
  Mentee mentee;

  CreateMenteeState(Mentee mentee){
    this.mentee = mentee;
  }

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
            controller: firstNameController,
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
            controller: lastNameController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16),
                hintText: "Last Name",
                border: OutlineInputBorder()),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: TextField(
            controller: phoneNumberController,
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
            controller: bioController,
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
              color: Colors.blue[800],
              onPressed: _next,
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
          onPressed: ()=> {Navigator.pop(context)},
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

  _next() {
    if(bioController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty){
      mentee.FirstName = firstNameController.text;
      mentee.LastName = lastNameController.text;
      mentee.PhoneNumber = phoneNumberController.text;
      mentee.Bio = bioController.text;
      Navigator.push(context, MaterialPageRoute(builder: (context) => MenteeQuestionaire(mentee: mentee ,)));
    }
    else{
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () =>{Navigator.pop(context)},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("OOPS"),
      content: Text("You forgot to answer everything"),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
