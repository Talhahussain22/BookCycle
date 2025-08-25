import 'package:bookcycle/PostAuth/Homepage/Model/bookModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyBooksRepo{
  
  final _firebaseFirstore=FirebaseFirestore.instance;
  final _firebaseAuth=FirebaseAuth.instance;
  
  Future<List<BookModel>> getMyBooks() async
  {
    try{
      String uid=_firebaseAuth.currentUser!.uid;
      final ref=await _firebaseFirstore.collection('books').where('ownerid',isEqualTo: uid).orderBy('createdAt',descending: true).get();
      return ref.docs.map((doc)=>BookModel.fromJson(doc.data())).toList();
    }catch(e){
      print('Error fetching books:${e.toString()}');
      throw e.toString();
    }
  }
}