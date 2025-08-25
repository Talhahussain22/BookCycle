part of 'book_detials_bloc.dart';

@immutable
sealed class BookDetialsEvent {}

class ChatButtonPressedEvent extends BookDetialsEvent{
  BookModel book;
  ChatButtonPressedEvent({required this.book});
}

class ViewIncrementEvent extends BookDetialsEvent{
  String bookid;
  int views;
  ViewIncrementEvent({required this.bookid,required this.views});

}
