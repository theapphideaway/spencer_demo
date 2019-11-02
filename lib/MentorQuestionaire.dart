import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:way_ahead/MentorEducation.dart';

import 'MenteePlans.dart';
import 'MentorIndustries.dart';
import 'SignUp.dart';

class MentorQuestionaire extends StatefulWidget {
  MentorQuestionaireState createState() => MentorQuestionaireState();
}

class MentorQuestionaireState extends State<MentorQuestionaire> {
  TextEditingController industryController = new TextEditingController();
  TextEditingController educationController = new TextEditingController();
  int currentQuestion = 0;
  int _veteranValue = 0;
  int _experienceValue = 0;
  bool _hasServed = false;
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

  void _handleVeteranStatusChange(int value) {
    setState(() {
      _veteranValue = value;

      switch (_veteranValue) {
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

  @override
  void initState() {
    industryController.text = "Select industry";
    educationController.text = "High School/GED";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    child: Column(
                      children: <Widget>[
                        Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 16,
                                top: 64,
                                right: 16,
                              ),
                              child: Image.asset('assets/QuestionIcon.png'),
                            )),
                        new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new Padding(
                                  padding: EdgeInsets.only(left: 16, right: 8),
                                  child: Divider(
                                    thickness: 3,
                                    color: currentQuestion == 0?Colors.blue[800]:currentQuestion == 1?Colors.grey[300]: Colors.grey[300],
                                  )),
                            ),
                            new Expanded(
                              child: new Padding(
                                  padding: EdgeInsets.only(left: 8, right: 16),
                                  child: Divider(
                                    thickness: 3,
                                    color: currentQuestion == 0?Colors.grey[300]:currentQuestion == 1? Colors.blue[800]: Colors.grey[300],
                                  )),
                            ),
                            new Expanded(
                              child: new Padding(
                                  padding: EdgeInsets.only(left: 8, right: 16),
                                  child: Divider(
                                    thickness: 3,
                                    color: currentQuestion == 0?Colors.grey[300]:currentQuestion == 1? Colors.grey[300]: Colors.blue[800] ,
                                  )),
                            )
                          ],
                        ),

                        Container(
                          height: 600,
                          width: double.infinity,
                          child: PageView.builder(
                            physics: new NeverScrollableScrollPhysics(),
                            itemBuilder: (context, position) {
                              position = currentQuestion;
                              return position == 0?Container(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 16),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(),
                                          ),
                                          Text("What do ",
                                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                                          Text("you do for a ",
                                              style: TextStyle(
                                                  color: Colors.blue[800],
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold)),
                                          Expanded(
                                            child: Container(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 16),
                                      child: Text("living?",
                                        style: TextStyle(
                                            color: Colors.blue[800],
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold)),),


                                    Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                          ),
                                          child: TextField(
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.all(16),
                                                hintText: "Job Title",
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10)
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(16),
                                          child: TextField(
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.all(16),
                                              hintText: "Company Name",
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                          ),
                                          child: TextFormField(
                                            onTap: mentorIndustry,
                                            controller: industryController,
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.all(16),
                                                suffixIcon: Icon(Icons.arrow_drop_down),
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10))),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(16),
                                          child: Container(
                                            height: 120,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: Colors.grey)
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.symmetric(vertical: 16),
                                                    child: Text("How many years experience do you have?", style: TextStyle(fontSize: 16),)),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(vertical: 0),
                                                  child: new Row(
                                                    children: <Widget>[
                                                      Expanded(child: Container(),),
                                                      new Padding(
                                                          padding: EdgeInsets.only(left: 0, right: 0),
                                                          child: Radio(
                                                            value: 0,
                                                            groupValue: _experienceValue,
                                                            onChanged: _handleExperienceValueChange,
                                                          )),
                                                      new Text(
                                                        "1-4",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Expanded(child: Container(),),
                                                      new Padding(
                                                          padding: EdgeInsets.only(left: 0, right: 0),
                                                          child: Radio(
                                                            value: 1,
                                                            groupValue: _experienceValue,
                                                            onChanged: _handleExperienceValueChange,
                                                          )),
                                                      new Text(
                                                        "5-9",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Expanded(child: Container(),),
                                                      new Padding(
                                                          padding: EdgeInsets.only(left: 0, right: 0),
                                                          child: Radio(
                                                            value: 2,
                                                            groupValue: _experienceValue,
                                                            onChanged: _handleExperienceValueChange,
                                                          )),
                                                      new Text(
                                                        "10+",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Expanded(child: Container(),),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ),
                                        Row(children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.all(16),
                                              child: Container(
                                                  child: FlatButton(
                                                    shape: RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            color: Colors.grey,
                                                            width: 1,
                                                            style: BorderStyle.solid),
                                                        borderRadius:
                                                        BorderRadius.circular(5)),
                                                    child: Text(
                                                      "Back",
                                                      style: TextStyle(
                                                          color: Colors.blue[800],
                                                          fontSize: 18),
                                                    ),
                                                    onPressed: ()=> {Navigator.pop(context)},
                                                  ))),

                                          Expanded(child: Container(),),

                                          Padding(
                                              padding: EdgeInsets.all(16),
                                              child: Container(
                                                  child: FlatButton(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(5)),
                                                    child: Text(
                                                      "Next",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18),
                                                    ),
                                                    color: Colors.blue[800],
                                                    onPressed: onNext ,
                                                  ))),
                                        ],),
                                      ],

                                    ),

                                  ],
                                ),
                              ):position == 1?





                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 16),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(),
                                          ),
                                          Text("Select your ",
                                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                                          Text("highest level of",
                                              style: TextStyle(
                                                  color: Colors.blue[800],
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold)),
                                          Expanded(
                                            child: Container(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(),
                                        ),
                                        Text("education ",
                                            style: TextStyle(color: Colors.blue[800],fontSize: 32, fontWeight: FontWeight.bold)),
                                        Text("attained",
                                            style: TextStyle(
                                                fontSize: 32,
                                                fontWeight: FontWeight.bold)),
                                        Expanded(
                                          child: Container(),
                                        ),
                                      ],
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top:16
                                      ),
                                      child: TextFormField(
                                        onTap: mentorEducation,
                                        controller: educationController,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(16),
                                            suffixIcon: Icon(Icons.arrow_drop_down),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10))),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(16),
                                      child: TextField(
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(16),
                                          hintText: "School Name",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.all(16),
                                          child: Container(
                                              child: FlatButton(
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Colors.grey,
                                                        width: 1,
                                                        style: BorderStyle.solid),
                                                    borderRadius:
                                                    BorderRadius.circular(5)),
                                                child: Text(
                                                  "Back",
                                                  style: TextStyle(
                                                      color: Colors.blue[800],
                                                      fontSize: 18),
                                                ),
                                                onPressed: onBack,
                                              ))),

                                      Expanded(child: Container(),),

                                      Padding(
                                          padding: EdgeInsets.all(16),
                                          child: Container(
                                              child: FlatButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(5)),
                                                child: Text(
                                                  "Next",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                                color: Colors.blue[800],
                                                onPressed: onNext ,
                                              ))),
                                    ],),
                                  ],
                                ),
                              ):



                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 16),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(),
                                          ),
                                          Text("Did you ever  ",
                                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                                          Text("serve in the ",
                                              style: TextStyle(
                                                  color: Colors.blue[800],
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold)),
                                          Expanded(
                                            child: Container(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 16),
                                      child: Text("military?",
                                          style: TextStyle(
                                              color: Colors.blue[800],
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold)),),
                                    Padding(
                                        padding:
                                        EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(child: Container()),
                                            FlatButton(
                                                child: Text(
                                                  "Yes",
                                                  style: _hasServed
                                                      ? TextStyle(color: Colors.white)
                                                      : TextStyle(color: Colors.grey),
                                                ),
                                                color: _hasServed
                                                    ? Colors.blue[800]
                                                    : Colors.transparent,
                                                onPressed: toggleServed,
                                                shape: RoundedRectangleBorder(
                                                    side:
                                                    BorderSide(color: Colors.grey, width: .5),
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(3),
                                                        bottomLeft: Radius.circular(3)))),
                                            FlatButton(
                                                child: Text(
                                                  "No",
                                                  style: !_hasServed
                                                      ? TextStyle(color: Colors.white)
                                                      : TextStyle(color: Colors.grey),
                                                ),
                                                color: !_hasServed
                                                    ? Colors.blue[800]
                                                    : Colors.transparent,
                                                onPressed: toggleServed,
                                                shape: RoundedRectangleBorder(
                                                    side:
                                                    BorderSide(color: Colors.grey, width: .5),
                                                    borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(3),
                                                        bottomRight: Radius.circular(3)))),
                                            Expanded(child: Container()),
                                          ],
                                        )),



                                    Column(
                                      children: <Widget>[
                                        Visibility(
                                          visible: _hasServed,
                                          child: Column(children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 16,
                                              right: 16,
                                            ),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.all(16),
                                                  hintText: "Branch",
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10)
                                                  )),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(16),
                                            child: TextField(
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.all(16),
                                                hintText: "Military Occupation",
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 16),
                                            child: TextField(
                                              keyboardType: TextInputType.number,
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.all(16),
                                                hintText: "Years Served",
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.all(16),
                                              child: Container(
                                                height: 120,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(color: Colors.grey)
                                                ),
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                        padding: EdgeInsets.symmetric(vertical: 16),
                                                        child: Text("Are you still active in the military or a veteran?", style: TextStyle(fontSize: 16),)),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 0),
                                                      child: new Row(
                                                        children: <Widget>[
                                                          Expanded(child: Container(),),
                                                          new Padding(
                                                              padding: EdgeInsets.only(left: 0, right: 0),
                                                              child: Radio(
                                                                value: 0,
                                                                groupValue: _veteranValue,
                                                                onChanged: _handleVeteranStatusChange,
                                                              )),
                                                          new Text(
                                                            "Still active",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                          Expanded(child: Container(),),
                                                          new Padding(
                                                              padding: EdgeInsets.only(left: 0, right: 0),
                                                              child: Radio(
                                                                value: 1,
                                                                groupValue: _veteranValue,
                                                                onChanged: _handleVeteranStatusChange,
                                                              )),
                                                          new Text(
                                                            "Veteran",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                          Expanded(child: Container(),),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                          ),
                                        ],),),

                                        Row(children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.all(16),
                                              child: Container(
                                                  child: FlatButton(
                                                    shape: RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            color: Colors.grey,
                                                            width: 1,
                                                            style: BorderStyle.solid),
                                                        borderRadius:
                                                        BorderRadius.circular(5)),
                                                    child: Text(
                                                      "Back",
                                                      style: TextStyle(
                                                          color: Colors.blue[800],
                                                          fontSize: 18),
                                                    ),
                                                    onPressed: onBack,
                                                  ))),

                                          Expanded(child: Container(),),

                                          Padding(
                                              padding: EdgeInsets.all(16),
                                              child: Container(
                                                  child: FlatButton(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(5)),
                                                    child: Text(
                                                      "Next",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18),
                                                    ),
                                                    color: Colors.blue[800],
                                                    onPressed: onNext ,
                                                  ))),
                                        ],),
                                      ],

                                    ),

                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )))));
  }

  mentorIndustry() async {
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
      industryController.text = type;
    });
  }

  mentorEducation() async {
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
      educationController.text = type;
    });
  }

  onNext(){
    setState(() {
      currentQuestion += 1;
    });
  }

  onBack(){
    setState(() {
      currentQuestion -= 1;
    });
  }

  onSignUp() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  toggleServed(){
    setState(() {
      _hasServed = !_hasServed;
    });
  }
}
