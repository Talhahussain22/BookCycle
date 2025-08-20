part of 'book_detials_bloc.dart';

@immutable
sealed class BookDetialsEvent {}

class ChatButtonPressedEvent extends BookDetialsEvent{
  BookModel book;
  ChatButtonPressedEvent({required this.book});
}
