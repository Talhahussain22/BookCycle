part of 'mybooksbloc_bloc.dart';

@immutable
sealed class MybooksblocState {}

final class MybooksblocInitial extends MybooksblocState {}

final class MybooksLoadingState extends MybooksblocState{}

final class MybooksLoadedState extends MybooksblocState{
  List<BookModel> books;
  MybooksLoadedState({required this.books});
}

final class MybooksErrorState extends MybooksblocState{
  String error;
  MybooksErrorState({required this.error});
}
