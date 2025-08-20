import 'package:bloc/bloc.dart';
import 'package:bookcycle/Authentication/SignUp/repository/signUp_repo.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupButtonPressed>((event, emit) async{
      emit(SignupLoadingState());
      String email = event.email;
      String password = event.password;
      String confirmpassword = event.confirmpassword;
      if (password != confirmpassword) {
        return emit(SignupErrorState(error: "Password doesn't match"));
      }
      try {
        final instance=SignupRepo();
        final response=await instance.SignUpUser(email: email,password: password, confirmpassword: confirmpassword);
        return emit(SignupLoadedState(uid: response.user?.uid));
      } catch (e) {
        return emit(SignupErrorState(error: e.toString()));
      }
    });
  }
}
