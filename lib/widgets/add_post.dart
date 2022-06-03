import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice_app/firestore.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key, required this.reload}) : super(key: key);
  final VoidCallback reload;

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> with Firestore {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  Image? chosenImage;
  String? path;

  validateTitle(value) {
    if (value.isEmpty) {
      return 'Vui lòng đặt tên cho bài đăng';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              width: 200, height: 200, child: chosenImage ?? const SizedBox()),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  side: const BorderSide(width: 2, color: Colors.black)),
              onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                final XFile? image = await _picker.pickImage(
                    source: ImageSource.gallery) as XFile;
                path = image!.path;
                File file = File(path!);
                setState(() {
                  chosenImage = Image.file(file);
                });
              },
              child: Text(
                'THÊM ẢNH',
                style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 13),
              )),
          TextFormField(
            controller: titleController,
            validator: (value) => validateTitle(value),
            decoration: const InputDecoration(
              hintText: 'Title',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2)),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  side: const BorderSide(width: 2, color: Colors.black)),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final now = DateTime.now();
                  Timestamp ts = Timestamp.fromDate(now);
                  await addPost(path!, titleController.text, ts);
                  Navigator.of(context).pop();
                  widget.reload();
                }
              },
              child: Text(
                'ĐĂNG',
                style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 13),
              ))
        ]),
      ),
    );
  }
}
