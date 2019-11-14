import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:way_ahead/Model/Message.dart';
import 'package:way_ahead/Services/FirebaseProvider.dart';

class Chat extends StatefulWidget {
  final String recieverId;
  final bool isMentee;
  final String chatId;
  final String name;
  Chat(
      {Key key,
      @required this.recieverId,
      @required this.isMentee,
      @optionalTypeArgs this.chatId,
      @required this.name});
  ChatState createState() => ChatState(recieverId, isMentee, chatId, name);
}

class ChatState extends State<Chat> {
  TextEditingController textController = new TextEditingController();
  var messages = new List<String>();
  var senders = new List<String>();
  String chatId;
  String messageKey;
  String userId;
  String email;
  String receiverId;
  bool isMentee;
  bool isInChat = false;
  String latestValue;
  String name;

  ChatState(String receiverId, bool isMentee, String chatId, String name) {
    var randomTwo = Random.secure();
    var random = Random.secure();
    messageKey = randomTwo.nextInt(100000000).toString();
    this.isMentee = isMentee;
    this.receiverId = receiverId;
    if (name != null) this.name = name;
    this.name = name;
    if (chatId == null) {
      chatId = random.nextInt(100000000).toString();
    } else {
      this.chatId = chatId;
    }
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.blue[800], //change your color here
          ),
          title: Text(
            name,
            style: TextStyle(color: Colors.blue[800]),
          ),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
                    child: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return
                      ListTile(
                        title: Align(
                            alignment: senders[index] == email
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: senders[index] == email
                                ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16)),
                                color: Colors.blue[800],
                              ),
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    messages[index],
                                    style: TextStyle(color: Colors.white),
                                  )),
                            )
                                : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16)),
                                color: Colors.blue[300],
                              ),
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    messages[index],
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ))
                    );
                  },
                )),

            Container(
              height: 50,
              child: Row(children: <Widget>[
                Flexible(child:
                TextField(
                  controller: textController,
                  decoration: InputDecoration(hintText: "Send a message",
                  focusColor: Colors.blue[800]),
                )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child:
                Icon(Icons.send, color: Colors.blue[800]),)
                ],),
            ),









          ],
        )));
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
          email = user.email,
          if (user == null)
            {}
          else
            {userId = user.uid, getLastestValue(), getMessages()}
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
      String sender;
      item.snapshot.value.forEach((key, value) {
        print(value);
        if (key == "sender") {
          sender = value;
          senders.add(sender);
        }
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
        if (item.value == null)
          latestValue = "0";
        else
          latestValue = item.value.toString();
      });
    } catch (e) {
      latestValue = "0";
    }
  }
}
