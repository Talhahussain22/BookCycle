import 'package:bloc/bloc.dart';
import 'package:bookcycle/PostAuth/ProfilePage/repository.dart';
import 'package:meta/meta.dart';

part 'profile_page_event.dart';
part 'profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  ProfilePageBloc() : super(ProfilePageInitial()) {
    on<GetProfilePageData>((event, emit) async{
      if(state is ProfilePageDataFetchedState)
        {
          return;
        }

      final data=await ProfilePageRepo().getProfileData();
      emit(ProfilePageDataFetchedState(data: data));
    });
  }
}
