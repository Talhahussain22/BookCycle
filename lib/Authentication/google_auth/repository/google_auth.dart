import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth
{
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  final  _googleSignIn=GoogleSignIn.instance;
  Future<dynamic> signinwithgoogle() async
  {
    try
    {
      await  _googleSignIn.initialize(serverClientId: "101700050440-1ffaf8s0nqh3hdpf1ccc3t2a40mjd3u1.apps.googleusercontent.com");
      final googleUser= await _googleSignIn.authenticate();
      if(googleUser==null) return null;

      final googleAuth= googleUser.authentication;

      final credential=GoogleAuthProvider.credential(idToken: googleAuth.idToken);

      final userCredential=await _firebaseAuth.signInWithCredential(credential);
      final user=userCredential.user;
      final firebasefirestore=FirebaseFirestore.instance;
      final doc=await firebasefirestore.collection('users').doc(user?.uid).get();
      bool isNewUser=!doc.exists;
      return [user,isNewUser];
    }catch(e)
    {

      throw e.toString();
    }

  }
}