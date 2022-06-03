import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:practice_app/firestore.dart';
import 'package:practice_app/user.dart';
import 'package:practice_app/widgets/bottomappbar.dart';
import 'package:practice_app/widgets/post.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  static const routeName = '/user_profile';

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> with Firestore {
  late Future<List<Post>> personalPosts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    personalPosts = getPersonalPosts();
  }

  void reload() {
    setState(() {
      personalPosts = getPersonalPosts();
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
          GestureDetector(
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? image =
                  await _picker.pickImage(source: ImageSource.gallery) as XFile;
              await changeAvatar(image!.path);
              setState(() {});
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(getCurrentUser().avatarPath),
              radius: 64,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            getCurrentUser().username,
            style: GoogleFonts.comfortaa(
                fontSize: 36, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            getCurrentUser().location,
            style:
                GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: 32,
          ),
          FutureBuilder<List<Post>>(
              future: personalPosts,
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
