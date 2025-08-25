part of 'book_detials_bloc.dart';

@immutable
sealed class BookDetialsState {}

final class BookDetialsInitial extends BookDetialsState {}

final class BookDetailsLoadingState extends BookDetialsState{}

final class BookDetailsLoadedState extends BookDetialsState{
  Map<String,dynamic>? data;
  BookModel book;
  Chat chatdoc;
  BookDetailsLoadedState({required this.data,required this.book,required this.chatdoc});

}

final class BookDetailsErrorState extends BookDetialsState{
  String error;
  BookDetailsErrorState({required this.error});
}
