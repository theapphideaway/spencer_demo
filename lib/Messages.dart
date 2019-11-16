import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:way_ahead/Model/BasicChatUser.dart';
import 'package:way_ahead/Services/FirebaseProvider.dart';

import 'Chat.dart';
import 'Model/Post.dart';

class Messages extends StatefulWidget{
  final isMentee;
  Messages({Key key, @required this.isMentee});
  MessagesState createState() => MessagesState(isMentee);
}

class MessagesState extends State<Messages>{
  bool isMentee;
  bool isLoading = true;
  Map<String, String> usersAndChatIds = new Map<String, String>();
  List<BasicChatUser> contacts = new List<BasicChatUser>();

  MessagesState(bool isMentee){
    this.isMentee = isMentee;
  }

  @override
  void initState() {
    getConversations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 32, vertical: 16),
              child: Image.asset(
                'assets/wayaheadLogo.png',
                width: 250,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                        padding:
                        EdgeInsets.only(left: 16, right: 8),
                        child: Divider(
                          color: Colors.grey,
                        )),
                  ),
                  new Text(
                    "Messages",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  new Expanded(
                    child: new Padding(
                        padding:
                        EdgeInsets.only(left: 8, right: 16),
                        child: Divider(
                          color: Colors.grey,
                        )),
                  ),


                ],
              ),
            ),
            isLoading? Expanded(child: Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue[800]),
                ),
              ),
            )):
            Container(
              height: 600,
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: ()=> {goToChat(contacts[index].userId, contacts[index].chatId,
                        contacts[index].firstName + " " + contacts[index].lastName )},
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                          child:Row(children: <Widget>[
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: contacts[index].profilePicture != null
                                    ? Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(30),
                                        image: DecorationImage(
                                          image: MemoryImage(
                                            contacts[index].profilePicture,
                                          ),
                                          fit: BoxFit.cover,
                                        )))
                                    : Image.asset(
                                  'assets/default_profile_picture.jpg',
                                  width: 40,
                                  height: 40,
                                )),
                        Text(contacts[index].firstName + " " + contacts[index].lastName, style: TextStyle(fontSize: 18), ),

                  ]))));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  goToChat(String receiverId, String chatId, String name) {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        Chat(isMentee: isMentee, recieverId: receiverId, chatId: chatId, name: name )));
  }

  getConversations()async {
    var id = await FirebaseProvider.firebaseProvider.getUserId();
    usersAndChatIds = await FirebaseProvider.firebaseProvider.getMessages(isMentee, id);
    getAllUsers(id);
  }

  getAllUsers(String id)async {
    var basicUsers = List<BasicChatUser>();
    usersAndChatIds.forEach((key, value)async {
      await FirebaseProvider.firebaseProvider.getUserInfoBasic(!isMentee, key, value).then((user)=>{
        basicUsers.add(user),
        print(basicUsers),
      setState(() {
      contacts = basicUsers;
      isLoading = false;
      })
      });

    });

  }

}