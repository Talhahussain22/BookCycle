part of 'resetpassword_bloc.dart';

@immutable
sealed class ResetpasswordEvent {}

final class ResetPasswordButtonPressed extends ResetpasswordEvent{
  String email;
  ResetPasswordButtonPressed({required this.email});
}
