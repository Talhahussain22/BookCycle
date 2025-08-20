part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginButtonPressedEvent extends LoginEvent{
  String email;
  String password;
  LoginButtonPressedEvent({required this.email,required this.password});
}
