import 'package:bookcycle/PostAuth/BookDetailPage/chatpage/Model/chatModel.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/chatpage/repository/chatrepo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPageScreen extends StatelessWidget {
  ChatPageScreen({super.key});

  final BookChatRepo repo=BookChatRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: StreamBuilder<List<Chat>>(stream:repo.allUserChats() , builder: (context,snapshot) {
        if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
        List<Chat> chats = snapshot.data!;
        if (chats.isEmpty) return const Center(child: Text('No conversations yet',style: TextStyle(color: Colors.black),));

        
        return ListView.builder(itemCount: chats.length,itemBuilder: (context,index) {
          final uid=FirebaseAuth.instance.currentUser!.uid;
          String otheruserid=chats[index].buyerId==uid?chats[index].sellerId:chats[index].buyerId;
          return ListTile(
            title: Text(otheruserid,style: TextStyle(color: Colors.black),),
          );
        });
      })
    );
  }
}
