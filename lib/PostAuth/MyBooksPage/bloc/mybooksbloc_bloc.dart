import 'package:bloc/bloc.dart';
import 'package:bookcycle/PostAuth/Homepage/Model/bookModel.dart';
import 'package:bookcycle/PostAuth/MyBooksPage/repository/my_books_repo.dart';
import 'package:meta/meta.dart';

part 'mybooksbloc_event.dart';
part 'mybooksbloc_state.dart';

class MybooksblocBloc extends Bloc<MybooksblocEvent, MybooksblocState> {
  MybooksblocBloc() : super(MybooksblocInitial()) {
    on<MybooksDataFetch>((event, emit) async{
      emit(MybooksLoadingState());
      try
          {
            final books=await MyBooksRepo().getMyBooks();

            emit(MybooksLoadedState(books: books));
          }catch(e){

        emit(MybooksErrorState(error: e.toString()));
      }
    });
  }
}
