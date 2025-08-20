part of 'homepage_bloc.dart';

@immutable
sealed class HomepageEvent {}

final class getHomepageDataEvent extends HomepageEvent{}
