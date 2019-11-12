import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:way_ahead/Model/BasicChatUser.dart';
import 'package:way_ahead/Model/Mentee.dart';
import 'package:way_ahead/Model/Mentor.dart';

class FirebaseProvider{
  FirebaseProvider._();

  static final FirebaseProvider firebaseProvider = FirebaseProvider._();

  Future<String> getUserId()async {
    var id;
    await FirebaseAuth.instance.currentUser().then((user) =>{
      id = user.uid
    });
    return id;
  }

  Future<String> signUp(String email, String password)async {
    AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;

  }

  addMentor(Mentor mentor){
    FirebaseDatabase.instance.reference().child('Mentors').child(mentor.id)
        .set({
      'id': mentor.id,
      'first_name': mentor.FirstName,
      'last_name': mentor.LastName,
      'phone_number': mentor.PhoneNumber,
      'bio': mentor.Bio,
      'job_title': mentor.JobTitle,
      'company_name': mentor.CompanyName,
      'industry': mentor.Industry,
      'experience': mentor.Experience,
      'education': mentor.Education,
      'school_name': mentor.SchoolName,
      'is_veteran': mentor.IsVeteran,
      'branch': mentor.MilitaryBranch,
      'military_occupation': mentor.MilitaryOccupation,
      'years_served': mentor.YearsServed,
      'still_active': mentor.MilitaryActivity,
      'is_mentor' : mentor.isMentor,
      'profile_picture' : mentor.ProfilePicture
    });

    print("Successfully Added Mentor");
  }

  addMentee(Mentee mentee){
    FirebaseDatabase.instance.reference().child('Mentees').child(mentee.Id)
        .set({
      'id': mentee.Id,
      'first_name': mentee.FirstName,
      'last_name': mentee.LastName,
      'phone_number': mentee.PhoneNumber,
      'bio': mentee.Bio,
      'plan': mentee.Plan,
      'job': mentee.Job,
      'company': mentee.Company,
      'school_name': mentee.SchoolName,
      'school_major': mentee.SchoolMajor,
      'military_branch': mentee.MilitaryBranch,
      'military_occupation': mentee.MilitaryOccupation,
      'certainty': mentee.Certainty,
      'is_mentor' : mentee.IsMentor,
      'profile_picture' : mentee.ProfilePicture
    });

    print("Successfully Added Mentee");
  }

  initiateChat(String sender, String text, String chatId, bool isMentee, String senderId, String receiverId, String messageKey){
    sendMessage(sender, text, chatId, messageKey);
    addChatToSender(isMentee, senderId, chatId, receiverId);
    addChatToReceiver(isMentee, receiverId, chatId, senderId);
  }

  sendMessage(String sender, String text, String chatId, String messageKey){

    FirebaseDatabase.instance.reference().child('Messages').child(chatId).child(messageKey)
        .set({
      'sender': sender,
      'text': text
    });

    print("Successfully Added Chat");
  }

  addChatToSender(bool isMentee, String senderId, String chatId, String receiverId){
    var tableName;
    if(isMentee == true) tableName = "Mentees";
    else tableName = "Mentors";

    FirebaseDatabase.instance.reference().child(tableName).child(senderId).child("Messages")
        .set({
      receiverId: chatId
    });
  }
  addChatToReceiver(bool isMentee, String receiverId, String chatId, String senderId){
    var tableName;
    if(!isMentee == true) tableName = "Mentees";
    else tableName = "Mentors";
    FirebaseDatabase.instance.reference().child(tableName).child(receiverId).child("Messages")
        .set({
      senderId: chatId
    });
  }

  Future<Map<String, String>> getMessages(bool isMentee, String userId)async {
    var tableName;
    Map<String, String> conversations = new Map<String, String> ();
    if(isMentee) tableName = "Mentees";
    else tableName = "Mentors";
    var chatIdResponse = await FirebaseDatabase.instance.reference().child(tableName).child(userId).child("Messages");
    await chatIdResponse.once().then((snapshot) => {
      print(snapshot.value),
      if (snapshot.value != null)
        {
          snapshot.value.forEach((key, value) {
            conversations[key] = value;
          }),

        },

    });
    return conversations;
  }

  Future<BasicChatUser> getUserInfoBasic(bool isMentee, String id, String chatId)async {
    var basicUser = BasicChatUser();
    var temp;
    var tableName;
    if(isMentee) tableName = "Mentees";
    else tableName = "Mentors";
    var firstNameResponse = await FirebaseDatabase.instance
        .reference()
        .child(tableName)
        .child(id)
        .child("first_name");
    await firstNameResponse.once().then((snapshot) => {
      print(snapshot.value),
      basicUser.firstName = snapshot.value,
    });
    var lastNameResponse = await FirebaseDatabase.instance
        .reference()
        .child(tableName)
        .child(id)
        .child("last_name");
    await lastNameResponse.once().then((snapshot) => {
    print(snapshot.value),
    basicUser.lastName = snapshot.value,
    });
    var pictureResponse = await FirebaseDatabase.instance
        .reference()
        .child(tableName)
        .child(id)
        .child("profile_picture");
    await pictureResponse.once().then((snapshot) => {
    print(snapshot.value),
      temp = snapshot.value,
      if (temp.toString().length > 200)
        {
          basicUser.profilePicture =  base64Decode(temp.toString()),
        }
    });
    basicUser.userId = id;
    basicUser.chatId = chatId;

    return basicUser;
  }
}