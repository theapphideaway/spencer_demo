import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MenteePlans.dart';
import 'SignUp.dart';

class MenteeQuestionaire extends StatefulWidget {
  MenteeQuestionaireState createState() => MenteeQuestionaireState();
}

class MenteeQuestionaireState extends State<MenteeQuestionaire> {
  TextEditingController planController = new TextEditingController();
  bool isWork = true;
  bool isSchool = false;
  bool isMilitary = false;
  @override
  void initState() {
    planController.text = "Straight To Work";
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
                    color: Colors.blue[800],
                  )),
            ),
            new Expanded(
              child: new Padding(
                  padding: EdgeInsets.only(left: 8, right: 16),
                  child: Divider(
                    thickness: 3,
                    color: Colors.grey[300],
                  )),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Text("What are your ",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              Text("current",
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
        Text("plans for the future?",
            style: TextStyle(
                color: Colors.blue[800],
                fontSize: 32,
                fontWeight: FontWeight.bold)),
        Container(
          height: 500,
          width: double.infinity,
          child: PageView.builder(
            physics: new NeverScrollableScrollPhysics(),
            itemBuilder: (context, position) {
              return PageView(
                physics: new NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16,
                            top: 32,
                            right: 16,
                          ),
                          child: TextFormField(
                            onTap: menteePlans,
                            controller: planController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(16),
                                suffixIcon: Icon(Icons.arrow_drop_down),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 32),
                              child: new Row(
                                children: <Widget>[
                                  new Expanded(
                                    child: new Padding(
                                        padding:
                                            EdgeInsets.only(left: 16, right: 8),
                                        child: Divider(
                                          color: Colors.black,
                                        )),
                                  ),
                                  new Text(
                                    isWork? "FUTURE JOB DETAIL": isSchool? "WHERE WOULD YOU LIKE TO GO?": isMilitary? "WHAT BRANCH AND OCCUPATION?": "",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  new Expanded(
                                    child: new Padding(
                                        padding:
                                            EdgeInsets.only(left: 8, right: 16),
                                        child: Divider(
                                          color: Colors.black,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 16,
                                right: 16,
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(16),
                                    hintText: isWork?"Job Title": isSchool? "School Name": isMilitary? "Branch":"",
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
                                  hintText: isWork? "Company Name": isSchool? "School Major": isMilitary? "Military Occupation":"",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                              ),
                            ),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
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
                                        "Next",
                                        style: TextStyle(
                                            color: Colors.blue[800],
                                            fontSize: 18),
                                      ),
                                    )))),
                          ],

                        ),

                      ],
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    )))));
  }

  menteePlans() async {
    final type = await Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return IncidentTypes();
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
    if(type == "Straight To Work") setState(() {
      isWork = true;
      isSchool = false;
      isMilitary = false;
    });
    if(type == "Trade School" || type == "College") setState(() {
      isSchool = true;
      isWork = false;
      isMilitary = false;
    });
    if(type == "Military" ) setState(() {
      isMilitary = true;
      isSchool = false;
      isWork = false;
    });
    setState(() {
      planController.text = type;
    });
  }

  onNext(){

  }

  onSignUp() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }
}