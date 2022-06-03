import 'package:flutter/material.dart';
import 'package:practice_app/screens/account.dart';
import 'package:practice_app/screens/chat.dart';
import 'package:practice_app/screens/discover.dart';
import 'package:practice_app/screens/intro.dart';
import 'package:practice_app/screens/login.dart';
import 'package:practice_app/screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practice_app/screens/seach.dart';
import 'package:practice_app/screens/user_profile.dart';
import 'firebase_options.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

// can fix: push new user profile screen thay vi pushnamed

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Practice App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const IntroScreen(),
        routes: {
          RegisterScreen.routeName: (context) => const RegisterScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          DiscoverScreen.routeName: (context) => DiscoverScreen(),
          SearchScreen.routeName: (context) => const SearchScreen(),
          UserProfile.routeName: (context) => UserProfile(),
          ChatScreen.routeName: (context) => ChatScreen(),
        });
  }
}
