import 'package:bloc/bloc.dart';
import 'package:bookcycle/PostAuth/Homepage/Model/bookModel.dart';
import 'package:bookcycle/PostAuth/SearchPage/repository/searchPageRepo.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<OnChangedInSearch>((event, emit) async{
      try
          {

            final books=await SearchPageRepo().getbooks(event.query);

            emit(SearchLoadedState(books: books));
          }catch(e){
        debugPrint(e.toString());
      }
    });
  }
}
