import 'package:bookcycle/ErrorHandling/error_handling.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepo
{
  Future LoginUser({
    required String email,
    required String password,

  }) async
  {
    final firebase=FirebaseAuth.instance;
    try {
      final response = await firebase.signInWithEmailAndPassword(email: email, password: password);
      return response;

    }on FirebaseAuthException catch(e)
    {

      String? error=ErrorHandling().getError(e.code);
      throw error??'';
    }
  }
}