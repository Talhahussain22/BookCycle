import 'package:cloud_firestore/cloud_firestore.dart';

class InboxPageRepo{

  Future<DocumentSnapshot> openDoc({
    required String bookid,
    required String sellerid,
    required String buyerid
}) async
  {
    String chatid = '${bookid}_${buyerid}_${sellerid}';

    final ref=FirebaseFirestore.instance.collection('chats').doc(chatid);
    final doc=await ref.get();
    return doc;

    }
  Future getOtherUserinfo(String otheruseid) async{
    try
        {
          final ref=await FirebaseFirestore.instance.collection('users').doc(otheruseid).get();
          return ref.data()??{} as Map<String,dynamic>;
        }catch(e){

        print(e.toString());
    }
  }
}