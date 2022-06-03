import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:practice_app/firestore.dart';
import 'package:practice_app/screens/message.dart';

import '../widgets/bottomappbar.dart';
import '../widgets/post.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen(
      {Key? key,
      required this.userId,
      required this.username,
      required this.avatarPath,
      required this.location})
      : super(key: key);

  final String username;
  final String avatarPath;
  final String location;
  final String userId;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> with Firestore {
  late Future<List<Post>> posts;

  @override
  void initState() {
    print(widget.userId);
    super.initState();
    posts = getPostsOfAUser(widget.userId);
  }

  void reload() {
    setState(() {
      posts = getPostsOfAUser(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 76,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(widget.avatarPath),
            radius: 64,
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            widget.username,
            style: GoogleFonts.comfortaa(
                fontSize: 36, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            widget.location,
            style:
                GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(primary: Colors.black),
                child: Text('FOLLOW ${widget.username.toUpperCase()}',
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 13))),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 2, color: Colors.black)),
                onPressed: () async {
                  var roomId = await addChatRoom(widget.userId);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MessageScreen(
                              roomId: roomId,
                              avatarPath: widget.avatarPath,
                              username: widget.username)));
                },
                child: Text(
                  'MESSAGE',
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w900),
                )),
          ),
          const SizedBox(
            height: 32,
          ),
          FutureBuilder<List<Post>>(
              future: posts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MasonryGrid(
                    column: 2,
                    children: snapshot.data!,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return const CircularProgressIndicator();
              })
          // con thieu masonrygrid cua posts nguoi dung
        ]),
      )),
      bottomNavigationBar: MyBottomAppBar(reload: reload),
    );
  }
}
