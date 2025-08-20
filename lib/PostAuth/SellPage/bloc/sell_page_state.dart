part of 'sell_page_bloc.dart';

@immutable
sealed class SellPageState {}

final class SellPageInitial extends SellPageState {}

final class SellPageLoadingState extends SellPageState{}

final class SellPageLoadedState extends SellPageState{}

final class SellPageErrorState extends SellPageState{
  String error;
  SellPageErrorState({required this.error});
}
