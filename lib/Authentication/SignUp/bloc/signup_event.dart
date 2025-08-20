part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

final class SignupButtonPressed extends SignupEvent{

  String email;
  String password;
  String confirmpassword;
  SignupButtonPressed({
    required this.email,
    required this.password,
    required this.confirmpassword,});
}
