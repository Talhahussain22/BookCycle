import 'package:bloc/bloc.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/chatpage/Model/chatModel.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/repository/bookdetailrepo.dart';
import 'package:bookcycle/PostAuth/Homepage/Model/bookModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../chatpage/repository/chatrepo.dart';

part 'book_detials_event.dart';
part 'book_detials_state.dart';

class BookDetialsBloc extends Bloc<BookDetialsEvent, BookDetialsState> {
  BookDetialsBloc() : super(BookDetialsInitial()) {
    on<ChatButtonPressedEvent>((event, emit) async {
      emit(BookDetailsLoadingState());
      try {
        BookModel book = event.book;
        final uid = FirebaseAuth.instance.currentUser!.uid;
        final usersnapshot =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        final snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(book.ownerid)
                .get();
        if (snapshot.exists && usersnapshot.exists) {
          final buyerdata = usersnapshot.data();
          final sellerdata = snapshot.data();


          final obj = await BookChatRepo().OpenorCreatechatDocument(
            bookid: book.bookid,
            sellerid: book.ownerid,
            booktitle: book.title,
            bookimagepath: book.imagepath,
            bookprice: book.price,
            ownername:
                '${sellerdata?['first name']} ${sellerdata?['last name']}',
            buyername: '${buyerdata?['first name']} ${buyerdata?['last name']}',
          );

          final docdata = await obj.get();
          Chat chatdoc = Chat.fromDoc(docdata);

          emit(
            BookDetailsLoadedState(
              data: sellerdata,
              book: book,
              chatdoc: chatdoc,
            ),
          );
        }
      } catch (e) {
        if (e.toString().contains('The service is currently unavailable')) {
          emit(
            BookDetailsErrorState(
              error: 'Please check your internet connection and try again',
            ),
          );
        }
        debugPrint(e.toString());
      }
    });

    on<ViewIncrementEvent>((event,state) async{
      await BookDetailRepo().incrementview(bookid: event.bookid, views: event.views);

    });
  }

}
