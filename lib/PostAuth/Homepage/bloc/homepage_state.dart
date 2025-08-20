part of 'homepage_bloc.dart';

@immutable
sealed class HomepageState {}

final class HomepageInitial extends HomepageState {}

final class HomepageLoadingState extends HomepageState{}

final class HomepageLoadedState extends HomepageState{
  List<BookModel> data;
  HomepageLoadedState({required this.data});
}

final class HomepageErrorState extends HomepageState{
  String error;
  HomepageErrorState({required this.error});
}
