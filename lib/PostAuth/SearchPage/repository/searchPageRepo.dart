import 'package:bookcycle/PostAuth/Homepage/Model/bookModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class SearchPageRepo
{
  final _firebaseFirestore=FirebaseFirestore.instance;

  Future<List<BookModel>> getbooks(String query) async
  {


    try
        {
          final ref=await _firebaseFirestore.collection('books').where('status',isEqualTo: 'Active').where('searchkeyword',arrayContains: query.toLowerCase()).get();
          return ref.docs.map((doc)=>BookModel.fromJson(doc.data())).toList();
        }catch(e){
      throw 'firestore search error:$e';
    }
  }
}