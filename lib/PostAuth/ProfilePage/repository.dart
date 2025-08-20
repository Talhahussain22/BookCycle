import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePageRepo{

  final firebaseauth=FirebaseAuth.instance;
  final firebaseFirstore=FirebaseFirestore.instance;

  Future<dynamic> getProfileData()async{
    try
        {
          final uid=firebaseauth.currentUser?.uid;

          final data=await firebaseFirstore.collection('users').doc(uid).get();
          if(data.exists)
            {
              return data.data();
            }
        }catch(e){
      print(e.toString());
    }
  }
}