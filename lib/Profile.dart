import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import 'Login.dart';
import 'MenteePlans.dart';
import 'MentorEducation.dart';
import 'MentorIndustries.dart';

class Profile extends StatefulWidget {
  final bool isMentee;

  Profile({Key key, @required this.isMentee});
  ProfileState createState() => ProfileState(isMentee);
}

class ProfileState extends State<Profile> {
  bool isMentee;
  bool isLoading = true;
  bool isEditing = false;
  bool isWork = true;
  bool isSchool = false;
  bool isMilitary = false;
  bool hasProfilePicture = false;
  int _experienceValue = 0;
  int _certaintyValue = 0;
  String firstName = "a";
  String lastName = "a";
  String email = "a";
  String bio = "a";
  String plan = "a";
  String planLabel;
  String labelOne = "a";
  String detailOne = "a";
  String labelTwo = "a";
  String detailTwo = "a";
  String labelThree = "a";
  String detailThree = "a";
  String labelFour = "a";
  String detailFour = "a";
  String labelFive = "a";
  String detailFive = "a";
  String labelSix = "a";
  String detailSix = "a";
  String labelSeven = "a";
  String detailSeven = "a";
  String labelEight = "a";
  String detailEight = "a";
  String certainty = "N/A";
  String phoneNumber;
  var profilePictureUrl;
  TextEditingController bioController = TextEditingController();
  TextEditingController planController = TextEditingController();
  TextEditingController detailOneController = TextEditingController();
  TextEditingController detailTwoController = TextEditingController();
  TextEditingController detailThreeController = TextEditingController();
  TextEditingController detailFourController = TextEditingController();
  TextEditingController detailFiveController = TextEditingController();
  TextEditingController detailSixController = TextEditingController();
  TextEditingController detailSevenController = TextEditingController();
  TextEditingController detailEightController = TextEditingController();
  TextEditingController _textFieldController = TextEditingController();

  ProfileState(bool isMentee) {
    this.isMentee = isMentee;
  }

  @override
  void initState() {
    getUser();
    super.initState();
    setState(() {
      //isLoading = false;
    });
  }

  void _showDialog(String detail) {
    var field;
    if (detail == "Job Title: ") field = "job_title";
    if (detail == "bio") field = "bio";
    if (detail == "Company Name: ") field = "company_name";
    if (detail == "Industry") field = "industry";
    if (detail == "Education") field = "education";
    if (detail == "School") field = "school_name";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "TextField in Dialog"),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Save"),
              onPressed: () {
                onSave(field);
                Navigator.pop(context);
              },
            ),
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.blue[800]),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            GestureDetector(
                                onTap: getProfilePicture,
                                child: profilePictureUrl != null
                                    ? Container(
                                        height: 470,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: MemoryImage(
                                                  profilePictureUrl,
                                                ),
                                                fit: BoxFit.cover,
                                                colorFilter: ColorFilter.mode(
                                                    Colors.black
                                                        .withOpacity(0.4),
                                                    BlendMode.colorBurn))))
                                    : Image.asset(
                                        'assets/default_profile_picture.jpg',
                                        width: double.infinity,
                                        height: 400,
                                      )),
                            Container(
                              color: Colors.blue[800],
                              width: double.infinity,
                              height: 60,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: FlatButton(
                                      onPressed: !isEditing
                                          ? onEdit
                                          : () => onSave(bio),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(child: Container()),
                                          Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                          !isEditing
                                              ? Text(" Edit Profile",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18))
                                              : Text(" Save Profile",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18)),
                                          Expanded(child: Container()),
                                        ],
                                      ))),
                            ),
                            Container(
                              height: 60,
                              width: double.infinity,
                              child: Row(
                                children: <Widget>[
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 32, bottom: 0),
                                        child: Text(
                                          "About",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      )),
                                  Expanded(child: Container()),
                                  Text(
                                    email,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Expanded(child: Container()),
                                ],
                              ),
                            ),
                            new Divider(
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(top: 370),
                                child: Center(
                                  child: Text(
                                    firstName + " " + lastName,
                                    style: TextStyle(
                                        color: Colors.grey[200], fontSize: 40),
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Row(children: <Widget>[
                                Expanded(
                                  child: Container(),
                                ),
                                Text(plan + "at " + detailOne,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey[200],
                                      fontSize: 18,
                                    )),
                                Expanded(
                                  child: Container(),
                                ),
                              ]),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 16, top: 34),
                                child: Row(
                                  children: <Widget>[
                                    GestureDetector(
                                        onTap: getProfilePicture,
                                        child: profilePictureUrl != null
                                            ? Container(
                                                height: 80,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    image: DecorationImage(
                                                      image: MemoryImage(
                                                        profilePictureUrl,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    )))
                                            : Image.asset(
                                                'assets/default_profile_picture.jpg',
                                                width: 80,
                                                height: 80,
                                              )),
                                    Expanded(
                                      child: Container(),
                                    )
                                  ],
                                ))
                          ],
                        )
                      ],
                    ),
                    !isEditing
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            child: Text(
                              bio,
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
                    new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Padding(
                              padding: EdgeInsets.only(left: 16, right: 8),
                              child: Divider(
                                color: Colors.grey,
                              )),
                        ),
                        new Text(
                          "PROFILE DETAILS",
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
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        runSpacing: 5.0,
                        spacing: 5.0,
                        children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 1, color: Colors.grey[400])),
                              child: GestureDetector(
                                onTap: () => mentorIndustry(),
                                child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(detailTwo)),
                              )),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 1, color: Colors.grey[400])),
                              child: GestureDetector(
                                onTap: () => mentorIndustry(),
                                child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(detailThree)),
                              )),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 1, color: Colors.grey[400])),
                              child: GestureDetector(
                                onTap: () => mentorEducation(),
                                child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(detailFour)),
                              )),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 1, color: Colors.grey[400])),
                              child: GestureDetector(
                                onTap: () => _showDialog("School"),
                                child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(detailFive)),
                              )),
                          Visibility(
                              visible: labelSix != "Not a Veteran",
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: 1, color: Colors.grey[400])),
                                child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(detailSix)),
                              )),
                          Visibility(
                              visible: labelSix != "Not a Veteran",
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: 1, color: Colors.grey[400])),
                                child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(detailSeven)),
                              )),
                        ],
                      ),
                    ),
                    new Container(
                      width: double.infinity,
                      child: new Padding(
                        padding: EdgeInsets.only(
                            left: 16, top: 10, right: 16, bottom: 32),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          padding: EdgeInsets.all(16),
                          color: Colors.transparent,
                          onPressed: () => {signOut()},
                          child: Text(
                            "Log out",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
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
      bioController.text = bio;
      planController.text = plan;
      detailOneController.text = detailOne;
      detailTwoController.text = detailTwo;
    });
  }

  onSave(String detail) async {
    isLoading = true;
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
                {updateMentee(user.uid)}
              else
                {updateMentors(user.uid, detail)}
            }
        });
  }

  updateMentors(String id, String field) async {
    await FirebaseDatabase.instance
        .reference()
        .child("Mentors")
        .child(id)
        .update({field: _textFieldController.text});
    getUser();
  }

  updateMentor(String id, String detail, String update) async {
    if (detail == bioController.text) {
      await FirebaseDatabase.instance
          .reference()
          .child("Mentors")
          .child(id)
          .update({"bio": update});
    }
    if (detail == planController.text) {
      await FirebaseDatabase.instance
          .reference()
          .child("Mentors")
          .child(id)
          .update({"job_title": planController.text});
    }
    if (detail == detailOneController.text) {
      await FirebaseDatabase.instance
          .reference()
          .child("Mentors")
          .child(id)
          .update({"company_name": detailOneController.text});
    }
    if (detail == detailTwoController.text) {
      await FirebaseDatabase.instance
          .reference()
          .child("Mentors")
          .child(id)
          .update({"industry": detailTwoController.text});
    }
    if (_experienceValue == 0) {
      await FirebaseDatabase.instance
          .reference()
          .child("Mentors")
          .child(id)
          .update({"experience": "1-4"});
    }
    if (_experienceValue == 1) {
      await FirebaseDatabase.instance
          .reference()
          .child("Mentors")
          .child(id)
          .update({"experience": "5-9"});
    }
    if (_experienceValue == 2) {
      await FirebaseDatabase.instance
          .reference()
          .child("Mentors")
          .child(id)
          .update({"experience": "10+"});
    }

    if (detail == detailFourController.text) {
      await FirebaseDatabase.instance
          .reference()
          .child("Mentors")
          .child(id)
          .update({"education": detailFourController.text});
    }
    if (detail == detailFiveController.text) {
      await FirebaseDatabase.instance
          .reference()
          .child("Mentors")
          .child(id)
          .update({"school_name": detailFiveController.text});
      setState(() {
        isEditing = false;
        isLoading = false;
        getUser();
      });
    }
  }

  updateMentorCompany(String id) async {}

  updateMentee(String id) async {
    await FirebaseDatabase.instance
        .reference()
        .child("Mentees")
        .child(id)
        .update({"bio": bioController.text});
    if (_certaintyValue == 0) {
      await FirebaseDatabase.instance
          .reference()
          .child("Mentees")
          .child(id)
          .update({"certainty": "certain"});
    }
    if (_certaintyValue == 1) {
      await FirebaseDatabase.instance
          .reference()
          .child("Mentees")
          .child(id)
          .update({"certainty": "mostly certain"});
    }
    if (_certaintyValue == 2) {
      await FirebaseDatabase.instance
          .reference()
          .child("Mentees")
          .child(id)
          .update({"certainty": "just interested"});
    }
    if (_certaintyValue == 3) {
      await FirebaseDatabase.instance
          .reference()
          .child("Mentees")
          .child(id)
          .update({"certainty": "no clue"});
    }
    if (labelOne == "Job Title: ") {
      await FirebaseDatabase.instance
          .reference()
          .child("Mentees")
          .child(id)
          .update({"job": detailOneController.text});
    }
    if (labelOne == "Military Branch: ") {
      await FirebaseDatabase.instance
          .reference()
          .child("Mentees")
          .child(id)
          .update({"military_branch": detailOneController.text});
    }
    if (labelOne == "School Name: ") {
      await FirebaseDatabase.instance
          .reference()
          .child("Mentees")
          .child(id)
          .update({"school_name": detailOneController.text});
    }
    if (labelTwo == "Company Name: ") {
      await FirebaseDatabase.instance
          .reference()
          .child("Mentees")
          .child(id)
          .update({"company": detailTwoController.text});
    }
    if (labelTwo == "Military Occupation: ") {
      await FirebaseDatabase.instance
          .reference()
          .child("Mentees")
          .child(id)
          .update({"military_occupation": detailTwoController.text});
    }
    if (labelTwo == "School Major: ") {
      await FirebaseDatabase.instance
          .reference()
          .child("Mentees")
          .child(id)
          .update({"school_name": detailTwoController.text});
    }
    setState(() {
      isEditing = false;
      getUser();
    });
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
    } catch (e) {}
  }

  getMentor(String id) async {
    var temp;
    var finalTempString;
    await FirebaseAuth.instance
        .currentUser()
        .then((user) => {email = user.email});

    var bioResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentors")
        .child(id)
        .child("bio");
    bioResponse.once().then((snapshot) => {
          print(snapshot.value),
          bio = snapshot.value,
        });

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
              profilePictureUrl = finalTempString,
            }
          else
            {profilePictureUrl = null},
        });
    var firstNameResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentors")
        .child(id)
        .child("first_name");
    firstNameResponse.once().then((snapshot) => {
          print(snapshot.value),
          firstName = snapshot.value,
        });

    var phoneResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentors")
        .child(id)
        .child("phone_number");
    phoneResponse.once().then((snapshot) => {
          print(snapshot.value),
          phoneNumber = snapshot.value,
        });

    var lastNameResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentors")
        .child(id)
        .child("last_name");
    lastNameResponse.once().then((snapshot) => {
          print(snapshot.value),
          lastName = snapshot.value,
        });
    var jobResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentors")
        .child(id)
        .child("job_title");
    jobResponse
        .once()
        .then((snapshot) => {print(snapshot.value), plan = snapshot.value});
    var companyNameResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentors")
        .child(id)
        .child("company_name");
    companyNameResponse.once().then((snapshot) => {
          print(snapshot.value),
          detailOne = snapshot.value,
        });
    var industryResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentors")
        .child(id)
        .child("industry");
    industryResponse.once().then((snapshot) => {
          print(snapshot.value),
          detailTwo = snapshot.value,
        });
    var experienceResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentors")
        .child(id)
        .child("experience");
    experienceResponse.once().then((snapshot) => {
          print(snapshot.value),
          detailThree = snapshot.value + " years",
          detailThreeController.text = detailThree
        });
    var educationResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentors")
        .child(id)
        .child("education");
    educationResponse.once().then((snapshot) => {
          print(snapshot.value),
          detailFour = snapshot.value,
          detailFourController.text = detailFour
        });
    var schoolNameResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentors")
        .child(id)
        .child("school_name");
    schoolNameResponse.once().then((snapshot) => {
          print(snapshot.value),
          detailFive = snapshot.value.toString(),
          detailFiveController.text = detailFive
        });

    var veteranResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentors")
        .child(id)
        .child("is_veteran");
    veteranResponse.once().then((snapshot) => {
          print(snapshot.value),
          detailSix = snapshot.value,
          detailSixController.text = detailSix,
          planLabel = "Job Title: ",
          labelOne = "Company Name",
          labelTwo = "Industry",
          labelThree = "Experience",
          labelFour = "Education",
          labelFive = "School Name",
          if (snapshot.value != null ||
              snapshot.value == true ||
              snapshot.value == "true")
            {getMilitaryMentor(id)}
          else
            {
              labelSix = "Not a Veteran",
              detailSix = "O",
              labelSeven = "O",
              detailSeven = "O",
              setState(() {
                isLoading = false;
              })
            }
        });
  }

  getMilitaryMentor(String id) async {
    var branchResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentors")
        .child(id)
        .child("branch");
    branchResponse.once().then((snapshot) => {
          print(snapshot.value),
          detailSix = snapshot.value.toString(),
          labelSix = "Military Branch",
          detailSixController.text = detailSix,
          setState(() {
            isMilitary = true;
          })
        });
    var occupationResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentors")
        .child(id)
        .child("military_occupation");
    occupationResponse.once().then((snapshot) => {
          print(snapshot.value),
          detailSeven = snapshot.value.toString(),
          labelSeven = "Military Occupation",
          detailSevenController.text = detailSeven,
          setState(() {
            isMilitary = true;
          })
        });
    var yearsServedResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentors")
        .child(id)
        .child("years_served");
    yearsServedResponse.once().then((snapshot) => {
          print(snapshot.value),
          detailEight = snapshot.value.toString(),
          labelEight = "Years Served",
          detailEightController.text = detailSeven,
          setState(() {
            isMilitary = true;
          })
        });
  }

  getMentee(String id) async {
    var temp;
    var finalTempString;
    await FirebaseAuth.instance
        .currentUser()
        .then((user) => {email = user.email});

    var pictureResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentors")
        .child(id)
        .child("profile_picture");
    pictureResponse.once().then((snapshot) => {
          print(snapshot.value),
          temp = snapshot.value,
          if (temp == "N/A" || temp == null)
            {profilePictureUrl = null}
          else
            {
              finalTempString = base64Decode(temp.toString()),
              profilePictureUrl = finalTempString,
            },
        });

    var bioResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentees")
        .child(id)
        .child("bio");
    bioResponse.once().then((snapshot) => {
          print(snapshot.value),
          bio = snapshot.value,
        });
    var firstNameResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentees")
        .child(id)
        .child("first_name");
    firstNameResponse.once().then((snapshot) => {
          print(snapshot.value),
          firstName = snapshot.value,
        });

    var lastNameResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentees")
        .child(id)
        .child("last_name");
    lastNameResponse.once().then((snapshot) => {
          print(snapshot.value),
          lastName = snapshot.value,
        });

    var certaintyResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentees")
        .child(id)
        .child("certainty");
    certaintyResponse.once().then((snapshot) => {
          print(snapshot.value),
          if (snapshot.value == 'certain') _certaintyValue = 0,
          if (snapshot.value == 'mostly certain') _certaintyValue = 1,
          if (snapshot.value == 'just interested') _certaintyValue = 2,
          if (snapshot.value == 'no clue') _certaintyValue = 3,
          certainty =
              '${snapshot.value[0].toUpperCase()}${snapshot.value.substring(1)}',
        });

    var planResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentees")
        .child(id)
        .child("plan");
    planResponse.once().then((snapshot) => {
          print(snapshot.value),
          setState(() {
            plan = snapshot.value;
            print(snapshot.value);
            getMenteeView(id);
          })
        });
  }

  getMenteeView(String id) async {
    planLabel = "Plan: ";
    if (plan == "Military") {
      labelOne = "Military Branch: ";
      labelTwo = "Military Occupation: ";
      getMenteeMilitaryInfo(id);
    }
    if (plan == "Straight To Work") {
      labelOne = "Job Title: ";
      labelTwo = "Company Name: ";
      getMenteeWorkInfo(id);
    } else {
      labelOne = "School Name: ";
      labelTwo = "School Major: ";
      getMenteeEducationInfo(id);
    }
  }

  getMenteeEducationInfo(String id) async {
    var schoolResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentees")
        .child(id)
        .child("school_name");
    schoolResponse.once().then((snapshot) => {
          print(snapshot.value),
          detailOne = snapshot.value,
          detailOneController.text = snapshot.value,
        });

    var majorResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentees")
        .child(id)
        .child("school_major");
    majorResponse.once().then((snapshot) => {
          print(snapshot.value),
          detailTwo = snapshot.value,
          detailTwoController.text = snapshot.value,
          setState(() {
            isLoading = false;
          })
        });
  }

  getMenteeWorkInfo(String id) async {
    var schoolResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentees")
        .child(id)
        .child("job");
    schoolResponse.once().then((snapshot) => {
          print(snapshot.value),
          detailOne = snapshot.value,
          detailOneController.text = snapshot.value,
        });

    var majorResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentees")
        .child(id)
        .child("company");
    majorResponse.once().then((snapshot) => {
          print(snapshot.value),
          detailTwo = snapshot.value,
          detailTwoController.text = snapshot.value,
          setState(() {
            isLoading = false;
          })
        });
  }

  getMenteeMilitaryInfo(String id) async {
    var schoolResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentees")
        .child(id)
        .child("military_branch");
    schoolResponse.once().then((snapshot) => {
          print(snapshot.value),
          detailOne = snapshot.value,
          detailOneController.text = snapshot.value,
        });

    var majorResponse = await FirebaseDatabase.instance
        .reference()
        .child("Mentees")
        .child(id)
        .child("military_occupation");
    majorResponse.once().then((snapshot) => {
          print(snapshot.value),
          detailTwo = snapshot.value,
          detailTwoController.text = snapshot.value,
          setState(() {
            isLoading = false;
          })
        });
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => Login()));
  }

  mentorIndustry() async {
    if (!isMentee) {
      final type = await Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return MentorIndustries();
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
      setState(() {
        detailTwo = type;
        onSave("Industry");
      });
    }
  }

  mentorEducation() async {
    if (!isMentee) {
      final type = await Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return MentorEducation();
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

      setState(() {
        detailFour = type;
        onSave("Education");
      });
    }
  }

  void _handleExperienceValueChange(int value) {
    setState(() {
      _experienceValue = value;

      switch (_experienceValue) {
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

  getProfilePicture() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    await FirebaseAuth.instance
        .currentUser()
        .then((user) => {addProfilePicture(user.uid, image)});
  }

  addProfilePicture(String id, File image) async {
    setState(() {
      isLoading = true;
    });
    var imageBytes = image.readAsBytesSync();
    String base64String = await base64Encode(imageBytes);
    try {
      await FirebaseDatabase.instance
          .reference()
          .child("Mentors")
          .child(id)
          .update({"profile_picture": base64String});
    } catch (e) {
      print(e);
    }

    var temp = await base64Decode(base64String.toString());
    setState(() {
      hasProfilePicture = true;
      profilePictureUrl = temp;
      isLoading = false;
    });
  }
}
