part of 'book_soldor_delete_bloc.dart';

@immutable
sealed class BookSoldOrDeleteState {}

final class BookSoldOrDeleteInitial extends BookSoldOrDeleteState {}

final class BookSoldOrDeleteLoadedState extends BookSoldOrDeleteState{}

final class BookSoldOrDeleteLoadingState extends BookSoldOrDeleteState{}

final class BookSoldOrDeleteErrorState extends BookSoldOrDeleteState{
  String error;
  BookSoldOrDeleteErrorState({required this.error});
}
