part of 'google_auth_bloc.dart';

@immutable
sealed class GoogleAuthState {}

final class GoogleAuthInitial extends GoogleAuthState {}

final class GoogleAuthErrorState extends GoogleAuthState{}

final class GoogleAuthSuccesState extends GoogleAuthState{
  bool? isNewUser;
  GoogleAuthSuccesState({this.isNewUser});
}
