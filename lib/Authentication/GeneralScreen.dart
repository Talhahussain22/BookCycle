import 'package:bookcycle/Authentication/Login/screen/login_screen.dart';
import 'package:bookcycle/Authentication/SignUp/screen/signup_screen.dart';
import 'package:bookcycle/Authentication/components/custom_button.dart';
import 'package:flutter/material.dart';

class GeneralScreen extends StatelessWidget {
  const GeneralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned(
              left: -100,
              top: -50,
              child: Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/feather2.png',
                  colorBlendMode: BlendMode.modulate,
                  height: 250,
                  width: 250,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
            ),
            Positioned(
              left: 50,
              top: 260,
              child: Align(
                alignment: Alignment.center,
                child: Transform.rotate(
                  angle: -1.7,
                  child: Image.asset(
                    'assets/images/feather2.png',
                    height: 350,
                    width: 350,
                    colorBlendMode: BlendMode.modulate,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
            ),
            Positioned(
              right: -120,
              bottom: -100,
              child: Transform.rotate(
                angle: -0.7,
                child: Image.asset(
                  'assets/images/feather2.png',
                  height: 350,
                  width: 350,
                  fit: BoxFit.fill,
                  colorBlendMode: BlendMode.modulate,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Column(
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
                  'share your books with other!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: CustomButton(
                    buttoncolor: Color(0xFFD65A31),
                    height: 55,
                    onTap: () {
                      print('tapped');
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    },
                    child: Center(
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: CustomButton(
                    buttoncolor: Color(0xFF393E46),
                    height: 55,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                    },
                    child: Center(
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
