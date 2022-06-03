import 'package:flutter/material.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField(
      {Key? key, required this.controller, required this.handleSubmit})
      : super(key: key);

  final VoidCallback handleSubmit;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            const Icon(Icons.mic, color: Color.fromRGBO(232, 21, 179, 1)),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color:
                      const Color.fromRGBO(232, 21, 179, 1).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Colors.black.withOpacity(0.64),
                    ),
                    const SizedBox(width: 16 / 4),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        onSubmitted: (_) => handleSubmit(),
                        decoration: const InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          handleSubmit();
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Color.fromRGBO(232, 21, 179, 0.64),
                        )),
                    const SizedBox(width: 16 / 4),
                    Icon(
                      Icons.attach_file,
                      color: Colors.black.withOpacity(0.64),
                    ),
                    const SizedBox(width: 16 / 4),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black.withOpacity(0.64),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
