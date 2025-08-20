import 'dart:io';

import 'package:bookcycle/PostAuth/SellPage/repository/userlocation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../ErrorHandling/error_handling.dart';
import '../../../services/image_store_And_fetch.dart';

class SellPageRepo{
  final firebaseauth=FirebaseAuth.instance;
  final firebaseFirestore=FirebaseFirestore.instance;

  Future<void> uploadBook({
    required File imagefile,
    required String condition,
    required String category,
    required String language,
    required String title,
    required String description,
    required String price,
    required String location,
    required dynamic lat,
    required dynamic lon
}) async
  {
    final firebaseauth=FirebaseAuth.instance;
    final firebaseFirestore=FirebaseFirestore.instance;


    try
        {
          String bookid=DateTime.now().millisecondsSinceEpoch.toString();
          String? ownerid=firebaseauth.currentUser?.uid;
          final imagepath=await SupaBaseImages().uploadImage(imagefile);

          FieldValue createdAt=FieldValue.serverTimestamp();
          if(imagepath==null)
            {
              throw 'unable to Upload \nCheck your internet connection';
            }

          await firebaseFirestore.collection('books').doc(bookid).set({
            'bookid':bookid,
            'ownerid':ownerid,
            'title':title,
            'description':description,
            'language':language,
            'category':category,
            'condition':condition,
            'price':price,
            'imagepath':imagepath,
            'address':location,
            'latitude':lat,
            'longitude':lon,
            'status':'Available',
            'createdAt':createdAt

          });

        }on FirebaseException catch(e){

      String? error=ErrorHandling().getError(e.code);
      throw error??'';
    }
    catch(e){

      throw e.toString();
    }


  }
}