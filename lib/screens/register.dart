import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_app/firebase_auth.dart';
import 'package:practice_app/firestore.dart';
import 'package:practice_app/user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with FirebaseAuthService, Firestore {
  bool step2 = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController handleController = TextEditingController();
  TextEditingController locationController = TextEditingController();

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
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

    if (value.isEmpty) {
      return 'Vui lòng nhập mật khẩu.';
    } else if (!RegExp(pattern).hasMatch(value)) {
      return 'Mật khẩu cần ít nhất một chữ cái viết thường, một chữ cái viết hoa, một chữ số và một kí tự đặc biệt.';
    }

    return null;
  }

  validateName(value) {
    if (value.isEmpty) {
      return 'Vui lòng nhập tên người dùng';
    } else if (value.length < 6) {
      return 'Tên người dùng cần ít nhất 6 kí tự';
    }
  }

  validateHandle(value) {
    if (value.isEmpty) {
      return 'Vui lòng nhập kí danh';
    } else if (value.length < 6) {
      return 'Kí danh cần ít nhất 6 kí tự';
    }
  }

  validateLocation(value) {
    if (value.isEmpty) {
      return 'Vui lòng nhập địa chỉ';
    }
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
                      onPressed: () => Navigator.pop(context),
                      icon: const ImageIcon(
                          AssetImage('assets/images/back.png'))),
                ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  'Register',
                  style: GoogleFonts.comfortaa(
                      color: Colors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 32,
                ),
                step2 == false
                    ? Form(
                        key: _formKey,
                        child: Column(children: [
                          TextFormField(
                            controller: emailController,
                            validator: (value) => validateEmail(value),
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
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
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      step2 = true;
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black),
                                child: Text('NEXT',
                                    style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 13))),
                          ),
                        ]),
                      )
                    : Form(
                        key: _formKey,
                        child: Column(children: [
                          TextFormField(
                            controller: nameController,
                            validator: (value) => validateName(value),
                            decoration: const InputDecoration(
                              hintText: 'Username',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: handleController,
                            validator: (value) => validateHandle(value),
                            decoration: const InputDecoration(
                              hintText: 'Handle',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: locationController,
                            validator: (value) => validateLocation(value),
                            decoration: const InputDecoration(
                              hintText: 'Location',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
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
                                    await signUp(emailController.text,
                                        passwordController.text, context);

                                    await addUser(
                                        nameController.text,
                                        handleController.text,
                                        locationController.text,
                                        userId);

                                    setCurrentUser(
                                        await getUserWithId(userId), userId);

                                    Timer(const Duration(milliseconds: 1000),
                                        () {
                                      emailController.clear();
                                      passwordController.clear();
                                      nameController.clear();
                                      handleController.clear();
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black),
                                child: Text('SIGN UP',
                                    style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 13))),
                          ),
                        ]),
                      )
              ],
            )),
      ),
    );
  }
}
