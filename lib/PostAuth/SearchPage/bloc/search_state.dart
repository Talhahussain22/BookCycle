part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoadingState extends SearchState{}

final class SearchLoadedState extends SearchState{
  List<BookModel> books;
  SearchLoadedState({required this.books});
}

final class SearchErrorState extends SearchState{
  String error;
  SearchErrorState({required this.error});
}
