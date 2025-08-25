import 'package:bloc/bloc.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/repository/bookdetailrepo.dart';
import 'package:meta/meta.dart';

part 'book_soldor_delete_event.dart';
part 'book_soldor_delete_state.dart';

class BookSoldorDeleteBloc extends Bloc<BookSoldOrDeleteEvent, BookSoldOrDeleteState> {
  BookSoldorDeleteBloc() : super(BookSoldOrDeleteInitial()) {
    on<onBookSoldOrDeleteButtonPressed>((event, emit) async{
      emit(BookSoldOrDeleteLoadingState());
      try
          {
            String status=event.status;
            String bookid=event.bookid;
            await BookDetailRepo().updateStatus(bookid: bookid, status: status);
            emit(BookSoldOrDeleteLoadedState());
          }catch(e){
        emit(BookSoldOrDeleteErrorState(error: e.toString()));
      }
    });
  }
}
