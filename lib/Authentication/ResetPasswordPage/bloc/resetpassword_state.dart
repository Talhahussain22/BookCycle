part of 'resetpassword_bloc.dart';

@immutable
sealed class ResetpasswordState {}

final class ResetpasswordInitial extends ResetpasswordState {}

final class ResetPasswordLoadingState extends ResetpasswordState{}
 final class ResetPasswordLoadedState extends ResetpasswordState{
 }
final class ResetPasswordErrorState extends ResetpasswordState{
  String error;
  ResetPasswordErrorState({required this.error});
}
