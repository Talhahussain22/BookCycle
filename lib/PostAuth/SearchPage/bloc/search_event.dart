part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

final class OnChangedInSearch extends SearchEvent{
  String query;
  OnChangedInSearch({required this.query});
}

final class OnItemPressedInSearch extends SearchEvent{
  String title;
  OnItemPressedInSearch({required this.title});
}
