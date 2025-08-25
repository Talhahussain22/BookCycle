part of 'book_soldor_delete_bloc.dart';

@immutable
sealed class BookSoldOrDeleteEvent {}

final class onBookSoldOrDeleteButtonPressed extends BookSoldOrDeleteEvent{
  String status;
  String bookid;
  onBookSoldOrDeleteButtonPressed({required this.status,required this.bookid});
}
