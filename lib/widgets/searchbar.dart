import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  SearchBar(
      {Key? key,
      required this.updateSearchResults,
      required this.textEditingController})
      : super(key: key);
  final Function updateSearchResults;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      onChanged: (value) => updateSearchResults(value),
      decoration: const InputDecoration(
        hintText: 'Search all photos',
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2)),
      ),
    );
  }
}
