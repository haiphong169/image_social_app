import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/firestore.dart';
import 'package:practice_app/user.dart';

class Message extends StatelessWidget {
  const Message(
      {Key? key,
      required this.senderId,
      required this.content,
      required this.date,
      required this.avatarPath})
      : super(key: key);

  final String content;
  final String senderId;
  final Timestamp date;
  final String avatarPath;

  factory Message.fromJson(Map<String, dynamic> json, String avatarPath) {
    return Message(
      senderId: json['senderId'],
      content: json['content'],
      date: json['date'],
      avatarPath: avatarPath,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: senderId == getCurrentUser().userId
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (senderId != getCurrentUser().userId)
            CircleAvatar(
              radius: 14,
              backgroundImage: NetworkImage(avatarPath),
            ),
          const SizedBox(
            width: 8,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(232, 21, 179, 1)
                    .withOpacity(senderId == getCurrentUser().userId ? 1 : 0.1),
                borderRadius: BorderRadius.circular(30)),
            child: Text(
              content,
              style: TextStyle(
                  fontSize: 16,
                  color: senderId == getCurrentUser().userId
                      ? Colors.white
                      : Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
