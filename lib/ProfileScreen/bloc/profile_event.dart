part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class ProfilePicSelectionButtonPressed extends ProfileEvent{
}

final class ProfileDataUploadButtonPressed extends ProfileEvent{
  String uid;
  File file;
  String fname;
  String lname;
  ProfileDataUploadButtonPressed({required this.uid,required this.file,required this.fname,required this.lname});
}
