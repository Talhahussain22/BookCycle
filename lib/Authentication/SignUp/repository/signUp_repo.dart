import 'package:bookcycle/ErrorHandling/error_handling.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupRepo
{
  Future SignUpUser({
    required String email,
    required String password,
    required String confirmpassword,
}) async
  {
    final firebase=FirebaseAuth.instance;
    try {
      final response = await firebase.createUserWithEmailAndPassword(email: email, password: password);

      // use uid from above response and create firestore document containing firstname lastname, phonenumber etc
      return response;
    }on FirebaseAuthException catch(e)
    {
      String? error=ErrorHandling().getError(e.code);
      throw error??'';
    }
  }
}