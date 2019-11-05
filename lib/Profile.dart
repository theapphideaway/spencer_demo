import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'MenteePlans.dart';

class Profile extends StatefulWidget {
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  bool isMentee = true;
  bool isLoading = true;
  bool isEditing = false;
  bool isWork = true;
  bool isSchool = false;
  bool isMilitary = false;
  int _certaintyValue = 0;
  String firstName = "a";
  String lastName= "a";
  String email= "a";
  String bio= "a";
  var plan= "a";
  String labelOne= "a";
  String detailOne= "a";
  String labelTwo= "a";
  String detailTwo= "a";
  String certainty;
  TextEditingController bioController = TextEditingController();
  TextEditingController planController = TextEditingController();
  TextEditingController detailOneController = TextEditingController();
  TextEditingController detailTwoController = TextEditingController();

  @override
  void initState() {
    getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: isLoading? Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue[800]),
              ),
            ),
          ):SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Container(
                  color: Colors.green,
                  height: 100,
                  width: 100,
                ),
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(left: 16, bottom: 8, right: 16),
                        child: Text(
                          firstName + " " + lastName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              email,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: FlatButton(
                                onPressed: isEditing ? onSave : onEdit,
                                color: Colors.blue[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                ),
                                child: isEditing
                                    ? Text(
                                        "Save",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      )
                                    : Text(
                                        "Edit",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                              ))
                        ],
                      ),
                    ],
                  ))
            ],
          ),
          !isEditing
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                  child: Text(bio,
                    style: TextStyle(fontSize: 18),
                  ))
              : Padding(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    controller: bioController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 100,
                    minLines: 10,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
          Padding(
              padding: EdgeInsets.only(left: 32, top: 16, right: 16, bottom: 16),
              child: Row(
                children: <Widget>[
                  Text(
                    "Plan: ",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  !isEditing
                      ? Text(plan, style: TextStyle(fontSize: 24))
                      : Padding(
                      padding: EdgeInsets.only(left: 16, top: 32, right: 16, bottom: 16),
                      child: Container(
                        width: 190,
                        child: TextField(
                          onTap: isMentee?menteePlans: (){},
                          controller: planController,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            contentPadding: EdgeInsets.all(16),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      )),
                ],
              )),
          Padding(
              padding:EdgeInsets.only(left: 32, top: 16, right: 16, bottom: 16),
              child: Row(
                children: <Widget>[
                  Text(
                    labelOne,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  !isEditing
                      ? Text(detailOne, style: TextStyle(fontSize: 24))
                      : Padding(
                      padding: EdgeInsets.all(16),
                      child: Container(
                        width: 150,
                        child: TextField(
                          controller: detailOneController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      )),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 32, top: 16, right: 16, bottom: 16),
              child: Row(
                children: <Widget>[
                  Text(
                    labelTwo,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  !isEditing
                      ? Text(detailTwo, style: TextStyle(fontSize: 24))
                      : Padding(
                      padding: EdgeInsets.all(16),
                      child: Container(
                        width: 150,
                        child: TextField(
                          controller: detailTwoController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      )),
                ],
              )),

          Padding(
              padding: EdgeInsets.only(left: 32, top: 16, right: 16, ),
              child: Row(
                children: <Widget>[
                  Text(
                    "Certainty: ",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  !isEditing
                      ? Text("College", style: TextStyle(fontSize: 24))
                      :Container()
                ],
              ),
          ),
          Visibility(
            visible: isEditing,
            child: Padding(
              padding: EdgeInsets.only(left: 32, right: 16,bottom: 32 ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0),
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                            padding: EdgeInsets.only(left: 0, right: 0),
                            child: Radio(
                              value: 0,
                              groupValue: _certaintyValue,
                              onChanged: _handleRadioValueChange,
                            )),
                        new Text(
                          "100% certain",
                          style: TextStyle(
                            color: Colors.black,
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
                              groupValue: _certaintyValue,
                              onChanged: _handleRadioValueChange,
                            )),
                        new Text(
                          "I have a good idea, but things could change",
                          style: TextStyle(
                            color: Colors.black,
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
                              value: 2,
                              groupValue: _certaintyValue,
                              onChanged: _handleRadioValueChange,
                            )),
                        new Text(
                          "Its something I\'m interested in, but who knows",
                          style: TextStyle(
                            color: Colors.black,
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
                              value: 3,
                              groupValue: _certaintyValue,
                              onChanged: _handleRadioValueChange,
                            )),
                        new Text(
                          "I have no clue what I want to do",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ),
          new Container(
            width: double.infinity,
            child: new Padding(
              padding: EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 32),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)
                ),
                padding: EdgeInsets.all(16),
                color: Colors.transparent,
                onPressed: ()=>{} ,
                child: Text("Log out",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                  ),),


              ),),),
        ],
      ),
    )));
  }

  menteePlans() async {
    final type = await Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return MenteePlans();
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
    if (type == "Straight To Work")
      setState(() {
        isWork = true;
        isSchool = false;
        isMilitary = false;
      });
    if (type == "Trade School" || type == "College")
      setState(() {
        isSchool = true;
        isWork = false;
        isMilitary = false;
      });
    if (type == "Military")
      setState(() {
        isMilitary = true;
        isSchool = false;
        isWork = false;
      });
    plan = type;

    setState(() {
      planController.text = plan;
    });
  }

  onEdit() {
    setState(() {
      isEditing = true;
      bioController.text =bio;
      planController.text = plan;
      detailOneController.text = detailOne;
      detailTwoController.text = detailTwo;
    });
  }

  onSave() async {

    await FirebaseAuth.instance.currentUser().then((user) =>  {
      if(user == null) {
        setState(() {
          isLoading = false;
        })
      } else  {
        updateUser(user.uid)
      }
    });

  }

  updateUser(String id)async {
    await FirebaseDatabase.instance.reference().child("Mentees").child(id).update({"bio": bioController.text});
    if(_certaintyValue == 0){
      await FirebaseDatabase.instance.reference().child("Mentees").child(id).update({"certainty": "certain"});
    }
    if(_certaintyValue == 1){
      await FirebaseDatabase.instance.reference().child("Mentees").child(id).update({"certainty": "mostly certain"});
    }
    if(_certaintyValue == 2){
      await FirebaseDatabase.instance.reference().child("Mentees").child(id).update({"certainty": "just interested"});
    }
    if(_certaintyValue == 3){
      await FirebaseDatabase.instance.reference().child("Mentees").child(id).update({"certainty": "no clue"});
    }
    if(labelOne == "Job Title: "){
       await FirebaseDatabase.instance.reference().child("Mentees").child(id).update({"job": detailOneController.text});
    }
    if(labelOne == "Military Branch: "){
      await FirebaseDatabase.instance.reference().child("Mentees").child(id).update({"military_branch": detailOneController.text});
    }
    if(labelOne == "School Name: "){
      await FirebaseDatabase.instance.reference().child("Mentees").child(id).update({"school_name": detailOneController.text});
    }
    if(labelTwo == "Company Name: "){
      await FirebaseDatabase.instance.reference().child("Mentees").child(id).update({"company": detailTwoController.text});
    }
    if(labelTwo == "Military Occupation: "){
      await FirebaseDatabase.instance.reference().child("Mentees").child(id).update({"military_occupation": detailTwoController.text});
    }
    if(labelTwo == "School Major: "){
      await FirebaseDatabase.instance.reference().child("Mentees").child(id).update({"school_name": detailTwoController.text});
    }
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _certaintyValue = value;

      switch (_certaintyValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
        case 3:
          break;
      }
    });
  }

  getUser() async {
    try {
      await FirebaseAuth.instance.currentUser().then((user) =>  {
        if(user == null) {
          setState(() {
            isLoading = false;
          })
        } else  {
          if(isMentee){
            getMentee(user.uid),
          } else{
            getMentor(user.uid),
          }
        }
      });

    } catch (e) {

    }
  }
  getMentor(String id)async {
    await FirebaseAuth.instance.currentUser().then((user)=>{
      email = user.email
    });


    var bioResponse = await FirebaseDatabase.instance.reference().child("Mentors").child(id).child("bio");
    bioResponse.once().then((snapshot) => {
      print(snapshot.value),
      bio = snapshot.value,

    });
    var firstNameResponse = await FirebaseDatabase.instance.reference().child("Mentors").child(id).child("first_name");
    firstNameResponse.once().then((snapshot) => {
      print(snapshot.value),
      firstName = snapshot.value,

    });

    var lastNameResponse = await FirebaseDatabase.instance.reference().child("Mentors").child(id).child("last_name");
    lastNameResponse.once().then((snapshot) => {
      print(snapshot.value),
      lastName = snapshot.value,

    });
    var jobResponse = await FirebaseDatabase.instance.reference().child("Mentors").child(id).child("job_title");
    jobResponse.once().then((snapshot) => {
      print(snapshot.value),

    });
    var companyNameResponse = await FirebaseDatabase.instance.reference().child("Mentors").child(id).child("company_name");
    companyNameResponse.once().then((snapshot) => {
      print(snapshot.value),
      lastName = snapshot.value,

    });
    var industryResponse = await FirebaseDatabase.instance.reference().child("Mentors").child(id).child("industry");
    industryResponse.once().then((snapshot) => {
      print(snapshot.value),
      lastName = snapshot.value,

    });
    var experienceResponse = await FirebaseDatabase.instance.reference().child("Mentors").child(id).child("experience");
    experienceResponse.once().then((snapshot) => {
      print(snapshot.value),
      lastName = snapshot.value,

    });
    var educationResponse = await FirebaseDatabase.instance.reference().child("Mentors").child(id).child("education");
    educationResponse.once().then((snapshot) => {
      print(snapshot.value),
      lastName = snapshot.value,

    });
    var schoolNameResponse = await FirebaseDatabase.instance.reference().child("Mentors").child(id).child("school_name");
    schoolNameResponse.once().then((snapshot) => {
      print(snapshot.value),
      lastName = snapshot.value,

    });

    var veteranResponse = await FirebaseDatabase.instance.reference().child("Mentors").child(id).child("is_veteran");
    veteranResponse.once().then((snapshot) => {
      print(snapshot.value),
      lastName = snapshot.value,

    });


  }

  getMentee(String id)async{
    await FirebaseAuth.instance.currentUser().then((user)=>{
      email = user.email
    });


    var bioResponse = await FirebaseDatabase.instance.reference().child("Mentees").child(id).child("bio");
    bioResponse.once().then((snapshot) => {
      print(snapshot.value),
      bio = snapshot.value,

    });
    var firstNameResponse = await FirebaseDatabase.instance.reference().child("Mentees").child(id).child("first_name");
    firstNameResponse.once().then((snapshot) => {
      print(snapshot.value),
      firstName = snapshot.value,

    });

    var lastNameResponse = await FirebaseDatabase.instance.reference().child("Mentees").child(id).child("last_name");
    lastNameResponse.once().then((snapshot) => {
      print(snapshot.value),
      lastName = snapshot.value,

    });

    var planResponse = await FirebaseDatabase.instance.reference().child("Mentees").child(id).child("plan");
    planResponse.once().then((snapshot) => {
      print(snapshot.value),
      setState(() {
        plan = snapshot.value;
        isLoading = false;
        print(snapshot.value);
        getMenteeView(id);
      })

    });

  }

  getMenteeView(String id)async {
    if(plan == "Military" ){
      labelOne = "Military Branch: ";
      labelTwo = "Military Occupation: ";
      getMenteeMilitaryInfo(id);
    }
    if(plan == "Straight To Work"){
      labelOne = "Job Title: ";
      labelTwo = "Company Name: ";
      getMenteeWorkInfo(id);
    }
    else{
      labelOne = "School Name: ";
      labelTwo = "School Major: ";
      getMenteeEducationInfo(id);
    }
    var certaintyResponse = await FirebaseDatabase.instance.reference().child("Mentees").child(id).child("certainty");
    certaintyResponse.once().then((snapshot) => {
      print(snapshot.value),
      certainty = snapshot.value,
      setState(() {
        isLoading = false;
      })
    });
  }
  getMenteeEducationInfo(String id)async {
    var schoolResponse = await FirebaseDatabase.instance.reference().child("Mentees").child(id).child("school_name");
    schoolResponse.once().then((snapshot) => {
      print(snapshot.value),
      detailOne = snapshot.value,
      detailOneController.text  = snapshot.value,

      setState(() {
        isLoading = false;
      })
    });

    var majorResponse = await FirebaseDatabase.instance.reference().child("Mentees").child(id).child("school_major");
    majorResponse.once().then((snapshot) => {
      print(snapshot.value),
      detailTwo = snapshot.value,
      detailTwoController.text = snapshot.value,
      setState(() {
        isLoading = false;
      })
    });
  }

  getMenteeWorkInfo(String id)async {
    var schoolResponse = await FirebaseDatabase.instance.reference().child("Mentees").child(id).child("job");
    schoolResponse.once().then((snapshot) => {
      print(snapshot.value),
      detailOne = snapshot.value,
      detailOneController.text  = snapshot.value,

      setState(() {
        isLoading = false;
      })
    });

    var majorResponse = await FirebaseDatabase.instance.reference().child("Mentees").child(id).child("company");
    majorResponse.once().then((snapshot) => {
      print(snapshot.value),
      detailTwo = snapshot.value,
      detailTwoController.text  = snapshot.value,
      setState(() {
        isLoading = false;
      })
    });
  }

  getMenteeMilitaryInfo(String id)async {
    var schoolResponse = await FirebaseDatabase.instance.reference().child("Mentees").child(id).child("military_branch");
    schoolResponse.once().then((snapshot) => {
      print(snapshot.value),
      detailOne = snapshot.value,
      detailOneController.text  = snapshot.value,

      setState(() {
        isLoading = false;
      })
    });

    var majorResponse = await FirebaseDatabase.instance.reference().child("Mentees").child(id).child("military_occupation");
    majorResponse.once().then((snapshot) => {
      print(snapshot.value),
      detailTwo = snapshot.value,
      detailTwoController.text  = snapshot.value,
      setState(() {
        isLoading = false;
      })
    });


  }
}
