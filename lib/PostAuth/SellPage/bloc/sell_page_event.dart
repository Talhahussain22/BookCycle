part of 'sell_page_bloc.dart';

@immutable
sealed class SellPageEvent {}

final class SellPagePostButtonPressed extends SellPageEvent {
  File imagefile;
  String condition;
  String category;
  String language;
  String title;
  String description;
  String price;
  String location;
  dynamic lat;
  dynamic lon;

  SellPagePostButtonPressed({
    required this.imagefile,
    required this.condition,
    required this.category,
    required this.title,
    required this.description,
    required this.language,
    required this.location,
    required this.lon,
    required this.lat,
    required this.price,
  });
}
