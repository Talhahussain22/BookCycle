import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bookcycle/PostAuth/SellPage/repository/sellpageRepo.dart';
import 'package:meta/meta.dart';

part 'sell_page_event.dart';
part 'sell_page_state.dart';

class SellPageBloc extends Bloc<SellPageEvent, SellPageState> {
  SellPageBloc() : super(SellPageInitial()) {
    on<SellPagePostButtonPressed>((event, emit) async{
      emit(SellPageLoadingState());
      try
          {
            await SellPageRepo().uploadBook(imagefile: event.imagefile, condition: event.condition, category: event.category, language: event.language, title: event.title, description: event.description, price: event.price, location: event.location, lat: event.lat, lon: event.lon);
            emit(SellPageLoadedState());
          }catch(e){
        emit(SellPageErrorState(error: e.toString()));
      }
    });
  }
}
