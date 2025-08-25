part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class InboxItemPressed extends ChatEvent{
  String bookid;
  String sellerid;
  String buyerid;
  InboxItemPressed({required this.bookid,required this.sellerid,required this.buyerid});
}
