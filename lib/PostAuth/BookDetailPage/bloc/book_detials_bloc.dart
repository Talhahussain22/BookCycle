import 'package:bloc/bloc.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/chatpage/Model/chatModel.dart';
import 'package:bookcycle/PostAuth/Homepage/Model/bookModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../chatpage/repository/chatrepo.dart';

part 'book_detials_event.dart';
part 'book_detials_state.dart';

class BookDetialsBloc extends Bloc<BookDetialsEvent, BookDetialsState> {
  BookDetialsBloc() : super(BookDetialsInitial()) {
    on<ChatButtonPressedEvent>((event, emit) async{
      try
          {
            BookModel book=event.book;
            final obj=await BookChatRepo().OpenorCreatechatDocument(bookid: book.bookid, sellerid: book.ownerid);
            final snapshot=await FirebaseFirestore.instance.collection('users').doc(book.ownerid).get();
            if(snapshot.exists)
            {
              final sellerdata=snapshot.data();
              final docdata=await obj.get();
              Chat chatdoc=Chat.fromDoc(docdata);
              emit(BookDetailsLoadedState(data: sellerdata,book: book,chatdoc: chatdoc));

            }
          }catch(e){
          debugPrint(e.toString());
      }
    });
  }
}
