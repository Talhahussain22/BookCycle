import 'dart:io';

import 'package:bookcycle/Authentication/components/custom_button.dart';
import 'package:bookcycle/Authentication/components/custom_textfield.dart';
import 'package:bookcycle/PostAuth/Dashboard.dart';
import 'package:bookcycle/PostAuth/Homepage/screen/Homepage.dart';
import 'package:bookcycle/ProfileScreen/bloc/profile_bloc.dart';
import 'package:bookcycle/consts/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? imagefile;
  late TextEditingController fnameController;
  late TextEditingController lnameController;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    fnameController = TextEditingController();
    lnameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfilePicSelectedState) {
          imagefile = state.selectedImage;
        }
        return Scaffold(

          floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
          body: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    GestureDetector(
                      onTap:
                          () => context.read<ProfileBloc>().add(
                            ProfilePicSelectionButtonPressed(),
                          ),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage:
                            imagefile != null ? FileImage(imagefile!) : null,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30, bottom: 10),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              Icons.camera_alt,
                              color: Color(0xFFD65A31),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                      child: CustomTextField(
                        hintext: 'First Name',
                        controller: fnameController,
                        validator: fieldValidator,
                        color: Color(0xFF393E46),
                        borderColor: Colors.white54,
                        hintextcolor: Colors.white54,
                        textColor: Colors.white,
                      ),
                    ),
              
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                      child: CustomTextField(
                        hintext: 'Last Name',
                        controller: lnameController,
                        validator: fieldValidator,
                        color: Color(0xFF393E46),
                        borderColor: Colors.white54,
                        hintextcolor: Colors.white54,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: BlocListener<ProfileBloc, ProfileState>(
            listener: (BuildContext context, state) {
              if (state is ProfileDataUploadedState) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
              }
              if (state is ProfileDataErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Center(child: Text(state.error))),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 45, right: 10,bottom: 15),
              child: CustomButton(
                buttoncolor: Color(0xFFD65A31),
                height: 55,
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    if (imagefile == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Image is Required')),
                      );
                      return;
                    }
                    final firebaseinstance = FirebaseAuth.instance;
                    String? uid = firebaseinstance.currentUser?.uid;
                    context.read<ProfileBloc>().add(
                      ProfileDataUploadButtonPressed(
                        uid: uid!,
                        file: imagefile!,
                        fname: fnameController.text.toString(),
                        lname: lnameController.text.toString(),
                      ),
                    );
                  }
                },
                child: Center(
                  child:
                      state is ProfileDataUploadingState
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                            'Update Profile',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
