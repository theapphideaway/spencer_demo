import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:way_ahead/Model/Mentor.dart';

class FirebaseProvider{
  FirebaseProvider._();

  static final FirebaseProvider firebaseProvider = FirebaseProvider._();

  signUp(String email, String password)async {
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
      'military_occupation': mentor.MilitaryBranch,
      'years_served': mentor.YearsServed,
      'still_active': mentor.MilitaryActivity,
    });

    print("Successfully Added Mentor");
  }
}