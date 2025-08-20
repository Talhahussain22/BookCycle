part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginLoadedState extends LoginState{
  String uid;
  LoginLoadedState({required this.uid});
}
final class LoginLoadingState extends LoginState{}
final class LoginErrorState extends LoginState{
  String error;
  LoginErrorState({required this.error});
}
