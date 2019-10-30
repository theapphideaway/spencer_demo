import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget{
  LoginState createState()=> LoginState();
}

class LoginState extends State<Login>{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        body: SingleChildScrollView(child: Container(child: Column(children: <Widget>[

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 64),
            child: Image.asset('assets/wayaheadLogo.png'),
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
                "LOGIN USING EMAIL",
                style: TextStyle(color: Colors.grey,),),
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
            padding: EdgeInsets.only(left: 16, top: 32, right: 16, ),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                  hintText: "Username",
                  border: OutlineInputBorder()
              ),
            ),
          ), Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16),
                hintText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding (
              padding: EdgeInsets.all(8),
              child: FlatButton(

                  child: Text("Forgot Password", textAlign: TextAlign.end, style: TextStyle(color: Colors.grey),))
          ),),

          new Container(
            width: double.infinity,
            child: new Padding(
              padding: EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 32),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)
                ),
                padding: EdgeInsets.all(16),
                color: Colors.indigoAccent,
                onPressed: ()=> {} ,
                child: Text("Login",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),),


              ),),),




          new Row(
              children: <Widget>[
                Expanded(child: Container()),
                new Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.grey,),),
                new Text(
                  "Sign up",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                Expanded(child: Container()),

              ],
          )


        ],
        )))));
  }

}