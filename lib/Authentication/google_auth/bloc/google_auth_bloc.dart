import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../repository/google_auth.dart';

part 'google_auth_event.dart';
part 'google_auth_state.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
  GoogleAuthBloc() : super(GoogleAuthInitial()) {
    on<GoogleButtonPressed>((event, emit) async{
      try
      {
        final user =await GoogleAuth().signinwithgoogle();
        if(user[0]!=null)
        {

          emit(GoogleAuthSuccesState(isNewUser: user[1]));
        }
      }catch(e)
      {
        print(e);
      }
    });
  }
}
