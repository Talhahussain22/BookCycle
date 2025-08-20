part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}


final class ProfilePicSelectedState extends ProfileState{
  File? selectedImage;
  ProfilePicSelectedState({this.selectedImage});
}

final class ProfileDataUploadingState extends ProfileState{}

final class ProfileDataUploadedState extends ProfileState{}

final class ProfileDataErrorState extends ProfileState{
  String error;
  ProfileDataErrorState({required this.error});
}
