import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:way_ahead/Services/FirebaseProvider.dart';

class Chat extends StatefulWidget {
  final String recieverId;
  final bool isMentee;
  Chat({Key key, @required this.recieverId, @required this.isMentee});
  ChatState createState() => ChatState(recieverId, isMentee);
}

class ChatState extends State<Chat> {
  TextEditingController textController = new TextEditingController();
  var messages = new List<String>();
  String chatId;
  String messageKey;
  String userId;
  String receiverId;
  bool isMentee;
  bool isInChat = false;
  String latestValue;

  ChatState(String receiverId, bool isMentee) {
    var randomTwo = Random.secure();
    messageKey = randomTwo.nextInt(100000000).toString();
    this.isMentee = isMentee;
    this.receiverId = receiverId;
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Center(
                    child: Column(
      children: <Widget>[
        TextField(
          controller: textController,
          decoration: InputDecoration(hintText: "Send a message"),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Center(
              child: GestureDetector(
            onTap: prepareMessage,
            child: Text(
              "Send",
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          )),
        ),
        Container(
            height: 700,
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            )),
      ],
    )))));
  }

  prepareMessage() async {
    var randomTwo = Random.secure();
    var newValue;
    await getLastestValue().then((_) => {
          FirebaseAuth.instance.currentUser().then((user) => {
                if (user == null)
                  {}
                else
                  {
                    newValue = int.parse(latestValue),
                    newValue += 1,
                    FirebaseProvider.firebaseProvider.initiateChat(
                        user.email,
                        textController.text,
                        chatId.toString(),
                        isMentee,
                        user.uid,
                        receiverId,
                        latestValue.toString()),
                    FirebaseDatabase.instance
                        .reference()
                        .child("Messages")
                        .child(chatId)
                        .update({"latest_value": newValue.toString()})
                  }
              })
        });
  }

  getUserId() async {
    await FirebaseAuth.instance.currentUser().then((user) => {
          if (user == null) {} else {userId = user.uid, tempGetChat()}
        });
  }

  getMessages() async {
    Map<dynamic, dynamic> temps;
    bool count = true;
    var userResponse = await FirebaseDatabase.instance
        .reference()
        .child("Messages")
        .child(chatId);

    userResponse.onChildAdded.listen((item) {
      print(item.snapshot.value);
      String message;
      item.snapshot.value.forEach((key, value) {
        print(value);
        if (key == "text") {
          message = value;
          messages.add(message);
        }
      });
      setState(() {});
    });
  }

  tempGetChat() async {
    var tableName;
    var partnerId = receiverId;
    var random = Random.secure();
    if (isMentee)
      tableName = "Mentees";
    else
      tableName = "Mentors";
    var bioResponse = await FirebaseDatabase.instance
        .reference()
        .child(tableName)
        .child(userId)
        .child("Messages");
    bioResponse.once().then((snapshot) => {
          print(snapshot.value),
          if (snapshot.value != null)
            {
              snapshot.value.forEach((key, value) {
                print(value);
                if (key == partnerId.toString()) {
                  chatId = value.toString();
                }
                getLastestValue();
                getMessages();
              }),
            },
          if (chatId == null) {chatId = random.nextInt(100000000).toString()},
        });
  }

  Future getLastestValue() async {
    try {
      var userResponse = FirebaseDatabase.instance
          .reference()
          .child("Messages")
          .child(chatId)
          .child("latest_value");

      await userResponse.once().then((item) {
        print(item.value);
        if(item.value == null) latestValue = "0";
        else latestValue = item.value.toString();
      });
    } catch (e) {
      latestValue = "0";
    }
  }
}
