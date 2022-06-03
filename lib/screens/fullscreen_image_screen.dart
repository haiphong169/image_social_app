import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_app/screens/user_profile.dart';

import '../user.dart';
import 'account.dart';

class FullscreenImageScreen extends StatelessWidget {
  const FullscreenImageScreen(
      {Key? key,
      required this.imagePath,
      required this.avatarPath,
      required this.username,
      required this.handle,
      required this.location,
      required this.userId})
      : super(key: key);
  final String imagePath;
  final String avatarPath;
  final String username;
  final String handle;
  final String userId;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.topCenter,
        children: [
          Image.network(
            imagePath,
            fit: BoxFit.fill,
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
            child: Container(
              margin: const EdgeInsets.only(top: 46),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                  color: Colors.white)),
                          Text(handle,
                              style: GoogleFonts.roboto(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white))
                        ],
                      )
                    ],
                  ),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const ImageIcon(
                        AssetImage('assets/images/X.png'),
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
