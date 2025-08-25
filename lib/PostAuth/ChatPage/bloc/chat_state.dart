part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class InboxChatLoadingState extends ChatState{}

final class InboxChatLoadedState extends ChatState{
  Chat chat;
  Map<String,dynamic> userinfo;
  InboxChatLoadedState({required this.chat,required this.userinfo});
}

final class InboxChatErrorState extends ChatState{
  String error;
  InboxChatErrorState({required this.error});
}
