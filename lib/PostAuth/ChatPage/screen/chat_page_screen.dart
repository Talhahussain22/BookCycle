import 'package:bookcycle/PostAuth/BookDetailPage/chatpage/Model/chatModel.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/chatpage/repository/chatrepo.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/chatpage/screen/chatpage.dart';
import 'package:bookcycle/PostAuth/ChatPage/bloc/chat_bloc.dart';
import 'package:bookcycle/PostAuth/Homepage/Model/bookModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:intl/intl.dart';

class ChatPageScreen extends StatelessWidget {
  ChatPageScreen({super.key});

  final BookChatRepo repo = BookChatRepo();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc,ChatState>(
      listener: (context,state){
        if(state is InboxChatErrorState)
          {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(showCloseIcon: true,behavior: SnackBarBehavior.floating,content: Text(state.error,style: TextStyle(fontFamily: 'Abel'),)));
          }
        if(state is InboxChatLoadedState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(personimagepath: state.userinfo['imagepath'], personName: '${state.userinfo['first name']} ${state.userinfo['last name']}', bookimagepath: state.chat.bookimagepath, booktitle: state.chat.booktitle, bookprice: state.chat.bookprice, chatdoc: state.chat)));
        }
      },
      builder: (context,state) {
        return ModalProgressHUD(
          inAsyncCall: state is InboxChatLoadingState,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Chats',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<Chat>>(
                    stream: repo.allUserChats(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      List<Chat> chats = snapshot.data!;
                      if (chats.isEmpty) {
                        return const Center(
                          child: Text(
                            'No conversations yet',
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          final uid = FirebaseAuth.instance.currentUser!.uid;
                          String imageurl = dotenv.get('imagefetchurl');
                          String bookurl = imageurl + chats[index].bookimagepath;
                          final today=DateFormat.d().format(DateTime.now());
                          final lastmessageDateorTime=today==DateFormat.d().format(chats[index].updatedAt!.toDate())?DateFormat.jm().format(chats[index].updatedAt!.toDate()):DateFormat.yMd().format(chats[index].updatedAt!.toDate());

                         

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: GestureDetector(
                              onTap: (){
                                context.read<ChatBloc>().add(InboxItemPressed(bookid: chats[index].bookId, sellerid: chats[index].sellerId, buyerid: chats[index].buyerId));
                              },
                              child: ListTile(
                                shape: Border(bottom: BorderSide(color: Colors.black12)),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CachedNetworkImage(
                                    imageUrl: bookurl,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fill,
                                    errorWidget:
                                        (context, _, __) => Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.purple.shade50,
                                          ),
                                        ),
                                  ),
                                ),
                                title: Text(
                                  chats[index].sellerId == uid
                                      ? chats[index].buyername
                                      : chats[index].ownername,
                                  style: TextStyle(fontSize: 14,fontFamily: 'Abel'),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      chats[index].booktitle,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
                                        overflow: TextOverflow.ellipsis,

                                      ),
                                    ),
                                    const SizedBox(height: 5,),
                                    Text(chats[index].lastMessage??'',maxLines: 1,style: TextStyle(fontSize: 12,fontFamily: 'Abel'),overflow: TextOverflow.ellipsis,)
                                  ],
                                ),
                                trailing: Column(
                                  children: [
                                    Text(lastmessageDateorTime,style: TextStyle(fontSize: 11,fontFamily: 'Abel'),),
                                    SizedBox(height: 10,)
                                  ],
                                ),

                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
