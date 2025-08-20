import 'package:bookcycle/PostAuth/BookDetailPage/chatpage/Model/chatModel.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/chatpage/Model/messageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Error Handling is remaining

class BookChatRepo {
  final firebaseauth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  Future<DocumentReference> OpenorCreatechatDocument({
    required String bookid,
    required String sellerid,
  }) async {
    String buyerid = firebaseauth.currentUser!.uid;
    String chatid = '${bookid}_${buyerid}_${sellerid}';

    final ref = firebaseFirestore.collection('chats').doc(chatid);
    final snap = await ref.get();

    if (!snap.exists) {
      await ref.set(
        Chat(
          chatId: chatid,
          bookId: bookid,
          buyerId: buyerid,
          sellerId: sellerid,
          participants: [buyerid, sellerid],
        ).toMap(),
      );
    }

    return ref;
  }

  Stream<List<Message>> messageStream(String chatid) {
    return firebaseFirestore
        .collection('chats')
        .doc(chatid)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((msg) => msg.docs.map((d) => Message.fromDoc(d)).toList());
  }

  Future<void> sendMessage({
    required String text,
    required String chatId,
  }) async {
    final uid = firebaseauth.currentUser!.uid;

    final chatDoc = firebaseFirestore.collection('chats').doc(chatId);
    final messageDoc = chatDoc.collection('messages').doc();


    final batch = firebaseFirestore.batch();

    batch.set(messageDoc, {
      'senderId': uid,
      'text': text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
      'status': 'sending',
    });

    batch.update(chatDoc, {
      'lastMessage': text.trim(),
      'lastSenderId': uid,
      'updatedAt': FieldValue.serverTimestamp(),
    });


    await batch.commit();


    await messageDoc.update({'status': 'sent'});
  }


  Stream<List<Chat>> allUserChats() {
    final uid = firebaseauth.currentUser!.uid;
    return firebaseFirestore
        .collection('chats')
        .where('participants', arrayContains: uid)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((qs) => qs.docs.map((q) => Chat.fromDoc(q)).toList());
  }


}
