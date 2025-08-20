import 'dart:io';

import 'package:bookcycle/services/image_store_And_fetch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileRepo
{
  void UploadProfileData({required String uid,required File file,required
  String fname,required String lname})async{

   try
       {
         final firebasefirestore=FirebaseFirestore.instance;
         final imagepath=await SupaBaseImages().uploadImage(file);
        await firebasefirestore.collection('users').doc(uid).set({
           "first_name":fname,
           "last_name":lname,
          "imagepath":imagepath
         });


       }catch(e){

     throw e.toString();
   }
  }
}