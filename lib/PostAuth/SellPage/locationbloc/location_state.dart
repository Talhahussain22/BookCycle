part of 'location_bloc.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationLoadingState extends LocationState{}

final class LocationLoadedState extends LocationState{
  String? location;
  dynamic lat;
  dynamic lon;
  LocationLoadedState({required this.location,required this.lat,required this.lon});
}

final class LocationErrorState extends LocationState{
  String error;
  LocationErrorState({required this.error});
}
