import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class BookDetailRepo {
  final _firebaseFirestore = FirebaseFirestore.instance;
  Future<void> updateStatus({
    required String bookid,
    required String status,
  }) async {
    await _firebaseFirestore.collection('books').doc(bookid).update({
      'status': status,
    });
  }

  Future<void> incrementview({required String bookid, required int views})async{
    try
        {
          final view=views+1;
          await _firebaseFirestore.collection('books').doc(bookid).update({
            'views':view
    });

  }catch(e){
      debugPrint(e.toString());
    }
    }
}
