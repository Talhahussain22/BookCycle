import 'package:bookcycle/Authentication/ResetPasswordPage/bloc/resetpassword_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../consts/validator.dart';
import '../../components/custom_button.dart';
import '../../components/custom_textfield.dart';

class ResetPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  ResetPasswordPage({super.key});
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF222831),
        leading: IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).clearSnackBars();
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back, color: Colors.white),
        ),
      ),
      body: BlocConsumer<ResetpasswordBloc, ResetpasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordLoadedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                duration: Duration(days: 1),
                showCloseIcon: true,
                closeIconColor: Colors.white,
                content: Center(
                  child: Text(
                    "Reset Password link sent to your email!\n if you don't find it check your Spam folder ",
                    style: TextStyle(fontFamily: 'Abel'),
                  ),
                ),
              ),
            );
          }
          if (state is ResetPasswordErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Center(
                  child: Text(
                    state.error,
                    style: TextStyle(fontFamily: 'Abel'),
                  ),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is ResetPasswordLoadingState,
            child: Form(
              key: _formkey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontFamily: 'Abel',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      child: CustomTextField(
                        hintext: 'Email ',
                        controller: emailController,
                        validator: emaildValidator,
                        color: Color(0xFF393E46),
                        borderColor: Colors.white54,
                        hintextcolor: Colors.white54,
                        textColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CustomButton(
                        buttoncolor: Color(0xFFD65A31),
                        onTap: () {
                          if (_formkey.currentState!.validate()) {
                            context.read<ResetpasswordBloc>().add(
                              ResetPasswordButtonPressed(
                                email: emailController.text.trim(),
                              ),
                            );
                          }
                        },
                        child: Center(
                          child: Text(
                            'Reset Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
