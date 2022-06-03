import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_app/screens/account.dart';
import 'package:practice_app/screens/user_profile.dart';
import 'package:practice_app/user.dart';
import 'package:practice_app/widgets/post.dart';

import '../screens/fullscreen_image_screen.dart';

class FeaturedPost extends Post {
  const FeaturedPost(
      {Key? key,
      required imagePath,
      required avatarPath,
      required username,
      required handle,
      required title,
      required date,
      required userId,
      required location})
      : super(
            location: location,
            imagePath: imagePath,
            avatarPath: avatarPath,
            username: username,
            handle: handle,
            title: title,
            date: date,
            userId: userId);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FullscreenImageScreen(
                      imagePath: imagePath,
                      avatarPath: avatarPath,
                      username: username,
                      handle: handle,
                      location: location,
                      userId: userId))),
          child: Container(
            height: 330,
            width: 350,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(imagePath))),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              if (getCurrentUser().userId == userId) {
                return const UserProfile();
              } else {
                return AccountScreen(
                    userId: userId,
                    username: username,
                    avatarPath: avatarPath,
                    location: location);
              }
            }));
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  avatarPath,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(username,
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      )),
                  Text(handle,
                      style: GoogleFonts.roboto(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54))
                ],
              )
            ],
          ),
        )
      ]),
    );
    ;
  }
}
