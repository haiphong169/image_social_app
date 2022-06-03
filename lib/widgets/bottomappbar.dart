import 'package:flutter/material.dart';
import 'package:practice_app/screens/chat.dart';
import 'package:practice_app/screens/discover.dart';
import 'package:practice_app/screens/user_profile.dart';
import 'package:practice_app/widgets/add_post.dart';

import '../screens/seach.dart';

class MyBottomAppBar extends StatelessWidget {
  MyBottomAppBar({Key? key, required this.reload}) : super(key: key);
  final VoidCallback reload;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name !=
                    DiscoverScreen.routeName) {
                  Navigator.pushNamed(context, DiscoverScreen.routeName);
                }
              },
              icon: const ImageIcon(AssetImage('assets/images/house.png'))),
          IconButton(
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name !=
                    SearchScreen.routeName) {
                  Navigator.pushNamed(context, SearchScreen.routeName);
                }
              },
              icon: const ImageIcon(
                  AssetImage('assets/images/magnifying_glass.png'))),
          Container(
            width: 70,
            height: 40,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/pink_background.png'))),
            child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      isDismissible: true,
                      context: context,
                      builder: (_) => AddPost(reload: reload));
                },
                icon: const ImageIcon(
                  AssetImage('assets/images/plus.png'),
                  color: Colors.white,
                )),
          ),
          IconButton(
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name !=
                    ChatScreen.routeName) {
                  Navigator.pushNamed(context, ChatScreen.routeName);
                }
              },
              icon:
                  const ImageIcon(AssetImage('assets/images/chat_bubble.png'))),
          IconButton(
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name !=
                    UserProfile.routeName) {
                  Navigator.pushNamed(context, UserProfile.routeName);
                }
              },
              icon: const ImageIcon(AssetImage('assets/images/person.png'))),
        ],
      ),
    ));
  }
}
