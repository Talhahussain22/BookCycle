import 'package:bloc/bloc.dart';
import 'package:bookcycle/Authentication/Login/repository/Login_repo.dart';
import 'package:bookcycle/ProfileScreen/bloc/profile_bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressedEvent>((event, emit) async{
      emit(LoginLoadingState());
      final instance=LoginRepo();
      try
          {
            final response=await instance.LoginUser(email: event.email, password: event.password);

            return emit(LoginLoadedState(uid: response.user?.uid));
          }catch(e){
        return emit(LoginErrorState(error: e.toString()));
      }
    });


  }

}
