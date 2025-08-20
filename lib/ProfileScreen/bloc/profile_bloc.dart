import 'dart:io';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:bookcycle/ProfileScreen/repository/profile_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfilePicSelectionButtonPressed>((event, emit) async{
      final imagePicker=ImagePicker();
      try{
        final pickimage=await imagePicker.pickImage(source: ImageSource.gallery);
        if(pickimage!=null)
          {

            final image=File(pickimage.path);
            emit(ProfilePicSelectedState(selectedImage: image));
          }
      }catch(e)
      {
        print(e.toString());
      }

    });
    on<ProfileDataUploadButtonPressed>((event,emit)async{
      emit(ProfileDataUploadingState());
      await Future.delayed(Duration(seconds: 3));
        try
            {
              final profileRepo=ProfileRepo();
              profileRepo.UploadProfileData(uid: event.uid,file: event.file,fname: event.fname, lname: event.lname);
              emit(ProfileDataUploadedState());
            }catch(e){
            emit(ProfileDataErrorState(error: e.toString()));
        }
    });
  }
}
