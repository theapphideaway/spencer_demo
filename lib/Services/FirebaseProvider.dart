import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:way_ahead/Model/Mentee.dart';
import 'package:way_ahead/Model/Mentor.dart';

class FirebaseProvider{
  FirebaseProvider._();

  static final FirebaseProvider firebaseProvider = FirebaseProvider._();

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
      'is_mentor' : mentor.isMentor
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
      'is_mentor' : mentee.IsMentor
    });

    print("Successfully Added Mentee");
  }
}