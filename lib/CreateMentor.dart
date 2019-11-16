import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:way_ahead/MentorQuestionaire.dart';

import 'Model/Mentor.dart';
import 'SignUp.dart';

class CreateMentor extends StatefulWidget {
  final Mentor mentor;
  CreateMentor({Key key, @required this.mentor});
  CreateMentorState createState() => CreateMentorState(mentor);
}

class CreateMentorState extends State<CreateMentor> {
  TextEditingController bioController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  Mentor mentor;

   CreateMentorState(Mentor mentor){
     this.mentor = mentor;
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 16, top: 64, right: 16, ),
                          child: Image.asset('assets/MentorIcon.png'),
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
                                  "Mentor Profile",
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
                            textCapitalization: TextCapitalization.words,
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
                            textCapitalization: TextCapitalization.words,
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
                            keyboardType: TextInputType.phone,
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
                            textCapitalization: TextCapitalization.sentences,
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
                              color: Colors.indigoAccent,
                              onPressed: onContinue,
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

  onContinue() {
    if(bioController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty){
      mentor.FirstName = firstNameController.text;
      mentor.LastName = lastNameController.text;
      mentor.PhoneNumber = phoneNumberController.text;
      mentor.Bio = bioController.text;
      Navigator.push(context, MaterialPageRoute(builder: (context) => MentorQuestionaire(mentor: mentor)));
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
