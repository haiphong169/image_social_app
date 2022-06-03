import 'package:flutter/material.dart';
import 'package:practice_app/firestore.dart';
import 'package:practice_app/widgets/bottomappbar.dart';
import 'package:practice_app/widgets/chat_card.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  static const routeName = '/chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with Firestore {
  late Future<List<ChatCard>> chatList;

  void reload() {
    return;
  }

  @override
  void initState() {
    super.initState();
    chatList = getAllChatRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: FutureBuilder<List<ChatCard>>(
        future: chatList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) => snapshot.data![index]));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: MyBottomAppBar(reload: reload),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const Text(
        'Chats',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
