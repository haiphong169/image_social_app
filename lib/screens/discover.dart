import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:practice_app/firebase_auth.dart';
import 'package:practice_app/firestore.dart';
import 'package:practice_app/widgets/bottomappbar.dart';
import 'package:practice_app/widgets/featured_post.dart';

import '../widgets/post.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  static const routeName = '/discover';

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with FirebaseAuthService, Firestore {
  late Future<List<Post>> posts;
  int numFeatured = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    posts = getAllPosts();
  }

  void reload() {
    setState(() {
      posts = getAllPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ElevatedButton(
                onPressed: () => signOut(context),
                child: const Text('Sign Out')),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Discover',
              style: GoogleFonts.comfortaa(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              'WHAT\'S NEW TODAY',
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: double.infinity,
              height: 400,
              child: FutureBuilder<List<Post>>(
                future: posts,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    numFeatured =
                        snapshot.data!.length >= 5 ? 5 : snapshot.data!.length;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: numFeatured,
                      itemBuilder: (context, index) => FeaturedPost(
                        location: snapshot.data![index].location,
                        userId: snapshot.data![index].userId,
                        avatarPath: snapshot.data![index].avatarPath,
                        imagePath: snapshot.data![index].imagePath,
                        username: snapshot.data![index].username,
                        handle: snapshot.data![index].handle,
                        title: snapshot.data![index].title,
                        date: snapshot.data![index].date,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            Text('BROWSE ALL',
                style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w900)),
            const SizedBox(height: 24),
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

                  return const Center(child: CircularProgressIndicator());
                }),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 2, color: Colors.black)),
                  onPressed: () {},
                  child: Text(
                    'SEE MORE',
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w900),
                  )),
            )
          ]),
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(
        reload: reload,
      ),
    );
  }
}
