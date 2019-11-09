import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget{
  FeedState createState() => FeedState();
}

class FeedState extends State<Feed>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Padding(
                            padding: EdgeInsets.only(left: 16, right: 8),
                            child: Divider(
                              color: Colors.grey,
                            )),
                      ),
                      new Text(
                        "My Mentor",
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
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                  )
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Padding(
                            padding: EdgeInsets.only(left: 16, right: 8),
                            child: Divider(
                              color: Colors.grey,
                            )),
                      ),
                      new Text(
                        "Posts",
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
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 100,
                    minLines: 10,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      border: OutlineInputBorder(),
                      hintText: "Ask a question or share something interesting"
                    ),
                  ),
                ),
                Row(children: <Widget>[
                  Expanded(child: Container()),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)
                    ),
                    padding: EdgeInsets.all(8),
                    color: Colors.blue[800],
                    onPressed: ()=>{},
                    child: Text("Create Post",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),),


                  )
                ],),
              ],)
      )),
    );
  }

}