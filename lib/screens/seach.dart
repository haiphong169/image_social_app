import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_app/firestore.dart';
import 'package:practice_app/widgets/bottomappbar.dart';
import 'package:practice_app/widgets/searchbar.dart';
import 'package:practice_app/widgets/searchresults.dart';

import '../widgets/post.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static const routeName = '/search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with Firestore {
  Future<List<Post>>? searchResults;
  final TextEditingController controller = TextEditingController();

  void reload() {
    setState(() {
      searchResults = searchPosts(controller.text);
    });
  }

  updateSearchResults(String value) {
    setState(() {
      searchResults = null;
      searchResults = searchPosts(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 76,
            ),
            Text(
              'Search',
              style: GoogleFonts.comfortaa(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 32,
            ),
            SearchBar(
              updateSearchResults: updateSearchResults,
              textEditingController: controller,
            ),
            const SizedBox(
              height: 32,
            ),
            FutureBuilder<List<Post>>(
                future: searchResults,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          snapshot.data!.isNotEmpty
                              ? Text(
                                  'ALL RESULTS',
                                  style: GoogleFonts.roboto(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w900),
                                )
                              : const SizedBox(),
                          Container(
                            height: 600,
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 11,
                                        mainAxisSpacing: 11,
                                        crossAxisCount: 3),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) =>
                                    snapshot.data![index]),
                          )
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const SizedBox();
                })
          ]),
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(
        reload: reload,
      ),
    );
  }
}
