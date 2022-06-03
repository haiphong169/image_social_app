import 'package:flutter/material.dart';
import 'package:practice_app/screens/message.dart';

class ChatCard extends StatelessWidget {
  const ChatCard(
      {Key? key,
      required this.avatarPath,
      required this.username,
      required this.lastMessage,
      required this.roomId})
      : super(key: key);
  final String avatarPath;
  final String username;
  final String lastMessage;
  final String roomId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessageScreen(
                roomId: roomId, avatarPath: avatarPath, username: username),
          )),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(avatarPath),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                username,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 6,
              ),
              Opacity(
                opacity: 0.64,
                child: Text(
                  lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w400),
                ),
              )
            ]),
          ))
        ]),
      ),
    );
  }
}
