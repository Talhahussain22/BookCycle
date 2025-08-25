import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordRepo{
  final firebaseauth=FirebaseAuth.instance;

  Future<void> resetPassword({required String email}) async{
    try{
      await firebaseauth.sendPasswordResetEmail(email: email);
    }on FirebaseException catch(e){

      if(e.code=='network-request-failed')
        {
          throw 'Please check your internet connection and try again';
        }
      if(e.code=='user-not-found')
        {
          throw 'No user found with this email!';
        }
      else
        {
          throw 'Reset Password error:${e.message}';
        }
    }
  }
}