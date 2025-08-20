import 'package:bookcycle/Authentication/Login/bloc/login_bloc.dart';
import 'package:bookcycle/Authentication/SignUp/bloc/signup_bloc.dart';
import 'package:bookcycle/Authentication/google_auth/bloc/google_auth_bloc.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/bloc/book_detials_bloc.dart';
import 'package:bookcycle/PostAuth/Homepage/bloc/homepage_bloc.dart';
import 'package:bookcycle/PostAuth/ProfilePage/bloc/profile_page_bloc.dart';
import 'package:bookcycle/PostAuth/SellPage/bloc/sell_page_bloc.dart';
import 'package:bookcycle/PostAuth/SellPage/locationbloc/location_bloc.dart';
import 'package:bookcycle/ProfileScreen/bloc/profile_bloc.dart';
import 'package:bookcycle/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,

    overlays: [],
  );


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await dotenv.load(fileName:".env");
  await Supabase.initialize(url: dotenv.get("supabaseUrl"), anonKey: dotenv.get('apikey'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>SignupBloc()),
        BlocProvider(create: (_)=>LoginBloc()),
        BlocProvider(create: (_)=>GoogleAuthBloc()),
        BlocProvider(create: (_)=>ProfileBloc()),
        BlocProvider(create: (_)=>ProfilePageBloc()),
        BlocProvider(create: (_)=>LocationBloc()),
        BlocProvider(create: (_)=>SellPageBloc()),
        BlocProvider(create: (_)=>HomepageBloc()),
        BlocProvider(create: (_)=>BookDetialsBloc())
      ],
      child: MaterialApp(
        title: 'Book Cycle',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFF222831)
        ),
        home: SplashScreen(),
      ),
    );
  }
}

