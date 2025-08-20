import 'package:bookcycle/ProfileScreen/screen/profile_screen.dart';
import 'package:bookcycle/Authentication/SignUp/bloc/signup_bloc.dart';
import 'package:bookcycle/Authentication/SignUp/repository/signUp_repo.dart';
import 'package:bookcycle/Authentication/components/custom_button.dart';
import 'package:bookcycle/Authentication/components/custom_textfield.dart';
import 'package:bookcycle/Authentication/google_auth/bloc/google_auth_bloc.dart';
import 'package:bookcycle/Authentication/google_auth/repository/google_auth.dart';
import 'package:bookcycle/consts/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmpasswordController;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmpasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF222831),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupLoadedState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          }
          if (state is SignupErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is SignupLoadingState,
            child: Form(
              key: _formkey,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: -20,
                      top: 200,
                      child: Transform.rotate(
                        angle: 5.9,
                        child: Image.asset(
                          'assets/images/feather2.png',
                          height: 500,
                          width: 300,
                          fit: BoxFit.fill,
                          colorBlendMode: BlendMode.modulate,
                          color: Colors.white.withOpacity(0.07),
                        ),
                      ),
                    ),

                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign up',
                            style: TextStyle(fontSize: 35, color: Colors.white),
                          ),
                          const SizedBox(height: 80),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
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
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                            child: CustomTextField(
                              hintext: 'Password',
                              controller: passwordController,
                              validator: passwordValidator,
                              color: Color(0xFF393E46),
                              borderColor: Colors.white54,
                              hintextcolor: Colors.white54,
                              textColor: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                            child: CustomTextField(
                              hintext: 'Confirm Password',
                              controller: confirmpasswordController,
                              validator: passwordValidator,
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
                                  context.read<SignupBloc>().add(
                                    SignupButtonPressed(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      confirmpassword:
                                          confirmpasswordController.text.trim(),
                                    ),
                                  );
                                }
                              },
                              child: Center(
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              children: [
                                Expanded(child: Divider(color: Colors.white38)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    'OR',
                                    style: TextStyle(color: Color(0xFFD65A31)),
                                  ),
                                ),
                                Expanded(child: Divider(color: Colors.white38)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 50),
                          BlocListener<GoogleAuthBloc, GoogleAuthState>(
                            listener: (context, state) {
                              if (state is GoogleAuthSuccesState) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileScreen(),
                                  ),
                                );
                              }
                            },
                            child: GestureDetector(
                              onTap: () async {
                                context.read<GoogleAuthBloc>().add(
                                  GoogleButtonPressed(),
                                );
                              },
                              child: Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF222831),
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(color: Colors.orange),
                                      BoxShadow(color: Colors.black54),
                                    ],
                                  ),
                                  child: Image.asset(
                                    'assets/images/google.png',
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
