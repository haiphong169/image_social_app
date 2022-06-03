import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_app/screens/login.dart';
import 'package:practice_app/screens/register.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: [
          Image.asset(
            'assets/images/intro_image.png',
            fit: BoxFit.fill,
          ),
          Image.asset('assets/images/logo.png')
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 167,
            height: 52,
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, LoginScreen.routeName),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    side: const BorderSide(width: 2, color: Colors.black)),
                child: Text(
                  'LOG IN',
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 13),
                )),
          ),
          Container(
            width: 167,
            height: 52,
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, RegisterScreen.routeName),
                style: ElevatedButton.styleFrom(primary: Colors.black),
                child: Text(
                  'REGISTER',
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 13),
                )),
          )
        ],
      )),
    );
  }
}
