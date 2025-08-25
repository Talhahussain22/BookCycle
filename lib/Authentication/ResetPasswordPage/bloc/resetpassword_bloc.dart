import 'package:bloc/bloc.dart';
import 'package:bookcycle/Authentication/ResetPasswordPage/repository/resetPasswordRepo.dart';
import 'package:meta/meta.dart';

part 'resetpassword_event.dart';
part 'resetpassword_state.dart';

class ResetpasswordBloc extends Bloc<ResetpasswordEvent, ResetpasswordState> {
  ResetpasswordBloc() : super(ResetpasswordInitial()) {
    on<ResetPasswordButtonPressed>((event, emit) async{
      emit(ResetPasswordLoadingState());
      try{
        await ResetPasswordRepo().resetPassword(email: event.email);
        emit(ResetPasswordLoadedState());
      }catch(e){
        emit(ResetPasswordErrorState(error: e.toString()));
      }
    });
  }
}
