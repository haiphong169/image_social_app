import 'dart:async';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_app/firebase_auth.dart';
import 'package:practice_app/firestore.dart';
import 'package:practice_app/user.dart';

class LoginScreen extends StatelessWidget with FirebaseAuthService, Firestore {
  LoginScreen({Key? key}) : super(key: key);

  static const routeName = '/login';

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  validateEmail(value) {
    final isValid = EmailValidator.validate(value);
    if (value.isEmpty) {
      return 'Vui lòng nhập email.';
    } else if (!isValid) {
      return 'Vui lòng nhập một email hợp lệ.';
    }
    return null;
  }

  validatePassword(value) {
    if (value.isEmpty) {
      return 'Vui lòng nhập mật khẩu.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: const Offset(-13, 0),
                  child: IconButton(
                      onPressed: () =>
                          Navigator.popUntil(context, (route) => route.isFirst),
                      icon: const ImageIcon(
                          AssetImage('assets/images/back.png'))),
                ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  'Log in',
                  style: GoogleFonts.comfortaa(
                      color: Colors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 32,
                ),
                Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      controller: emailController,
                      validator: (value) => validateEmail(value),
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.multiline,
                      validator: (value) => validatePassword(value),
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await signIn(emailController.text,
                                  passwordController.text, context);
                              setCurrentUser(
                                  await getUserWithId(userId), userId);
                              Timer(const Duration(milliseconds: 1000), () {
                                emailController.clear();
                                passwordController.clear();
                              });
                            }
                          },
                          style:
                              ElevatedButton.styleFrom(primary: Colors.black),
                          child: Text('LOG IN',
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 13))),
                    ),
                  ]),
                ),
              ],
            )),
      ),
    );
  }
}
