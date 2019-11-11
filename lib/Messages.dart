import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Chat.dart';

class Messages extends StatefulWidget{
  MessagesState createState() => MessagesState();
}

class MessagesState extends State<Messages>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(child: Text("Go to chat"),
        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => Chat())),),
      ),
    );
  }

}