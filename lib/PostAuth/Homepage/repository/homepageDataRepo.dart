import 'package:bookcycle/ErrorHandling/error_handling.dart';
import 'package:bookcycle/PostAuth/Homepage/Model/bookModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HompePageRepo
{
  final firebaseFirestore=FirebaseFirestore.instance;
  
  Future<List<BookModel>> getData() async
  {
    List<BookModel> allBooks;
    try
        {
          Query booksquery=firebaseFirestore.collection('books').orderBy('createdAt',descending: true).limit(10);
          QuerySnapshot data =await booksquery.get();

          allBooks=data.docs.map((doc)=>BookModel.fromJson(doc.data() as Map<String,dynamic>)).toList();

          return allBooks;
        }on FirebaseException catch(e)
    {
      String? error=ErrorHandling().getError(e.code);
      throw error??'';
    }catch(e)
    {
      throw e.toString();
    }
  }
}