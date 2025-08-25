import 'package:bloc/bloc.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/chatpage/Model/chatModel.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/chatpage/screen/chatpage.dart';
import 'package:bookcycle/PostAuth/ChatPage/repository/chatrepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<InboxItemPressed>((event, emit) async{
      String bookid=event.bookid;
      String buyerid=event.buyerid;
      String sellerid=event.sellerid;

      emit(InboxChatLoadingState());
      try{

        final uid=FirebaseAuth.instance.currentUser!.uid;
        final doc=await InboxPageRepo().openDoc(bookid: bookid, sellerid: sellerid, buyerid: buyerid);


        final chat=Chat.fromDoc(doc);


        String otheruserid=uid==chat.buyerId?chat.sellerId:chat.buyerId;

        final userinfo=await InboxPageRepo().getOtherUserinfo(otheruserid);
        if(userinfo==null)
          {
            return emit(InboxChatErrorState(error: 'Please check your internet connection and try again'));
          }
        emit(InboxChatLoadedState(chat: chat,userinfo: userinfo));
      }catch(e){
        emit(InboxChatErrorState(error: e.toString()));
      }
    });
  }
}
