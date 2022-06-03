import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/firestore.dart';
import 'package:practice_app/widgets/chat_input_field.dart';
import 'package:practice_app/widgets/text_message.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen(
      {Key? key,
      required this.roomId,
      required this.avatarPath,
      required this.username})
      : super(key: key);

  final String username;
  final String avatarPath;
  final String roomId;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> with Firestore {
  late Future<List<Message>> messages;
  TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messages = getAllMessagesInAChatRoom(widget.roomId);
  }

  void addNewMessages() {
    if (inputController.text.isNotEmpty) {
      addMessage(widget.roomId, inputController.text,
          Timestamp.fromDate(DateTime.now()));
      inputController.clear();
      setState(() {
        messages = getAllMessagesInAChatRoom(widget.roomId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder<List<Message>>(
            future: messages,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemBuilder: (context, index) => snapshot.data![index],
                  itemCount: snapshot.data!.length,
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        )),
        ChatInputField(
          controller: inputController,
          handleSubmit: addNewMessages,
        )
      ]),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: const BackButton(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        widget.username,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
