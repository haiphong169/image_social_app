import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_app/screens/fullscreen_image_screen.dart';

class Post extends StatelessWidget {
  const Post(
      {Key? key,
      required this.imagePath,
      required this.avatarPath,
      required this.username,
      required this.handle,
      required this.title,
      required this.date,
      required this.userId,
      required this.location})
      : super(key: key);
  final String userId;
  final String location;
  final String imagePath;
  final String avatarPath;
  final String username;
  final String handle;
  final String title;
  final Timestamp date;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FullscreenImageScreen(
                      imagePath: imagePath,
                      avatarPath: avatarPath,
                      username: username,
                      handle: handle,
                      location: location,
                      userId: userId,
                    ))),
        child: Image.network(imagePath));
  }
}
