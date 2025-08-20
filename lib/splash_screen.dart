import 'dart:async';

import 'package:bookcycle/Authentication/GeneralScreen.dart';
import 'package:bookcycle/PostAuth/Dashboard.dart';
import 'package:bookcycle/ProfileScreen/screen/profile_screen.dart';
import 'package:bookcycle/PostAuth/Homepage/screen/Homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 4),
      () => checkuser()
    );
    super.initState();
  }

  void checkuser() async {
    final _firebaseauth = FirebaseAuth.instance;
    final _firebasestore=FirebaseFirestore.instance;
    if (_firebaseauth.currentUser == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GeneralScreen()),
      );
      return;
    }
    try
        {
          final doc=await _firebasestore.collection('users').doc(_firebaseauth.currentUser!.uid).get();

          if(doc.exists)
            {

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard()));
            }
          else
            {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
            }

        }catch(e){
      print(e.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Book Cycle',
              style: TextStyle(
                color: Color(0xFFD65A31),
                fontFamily: 'Gravitas',
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'sell your books',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(
                'assets/images/bookpile6.png',
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
