import 'package:bloc/bloc.dart';
import 'package:bookcycle/PostAuth/Homepage/Model/bookModel.dart';
import 'package:bookcycle/PostAuth/Homepage/repository/homepageDataRepo.dart';
import 'package:meta/meta.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(HomepageInitial()) {
    on<getHomepageDataEvent>((event, emit) async{
      emit(HomepageLoadingState());
      try
          {
            List<BookModel> data=await HompePageRepo().getData();
            emit(HomepageLoadedState(data: data));
          }catch(e){
        print(e.toString());
        emit(HomepageErrorState(error: e.toString()));
      }
    });
  }
}
