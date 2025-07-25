import 'package:flutter/material.dart';
import 'package:seven/core/utils/colors.dart';
import 'package:seven/features/view_model/search_provider.dart';
import 'package:provider/provider.dart';

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<SearchProvider>(context, listen: false);

    return TextField(
      onChanged: (value) {
        prov.search(value);
      },
      controller: prov.searchController,
      cursorColor: red,
      style: TextStyle(fontFamily: "Quicksand", color: white),
      decoration: InputDecoration(
        hintText: "Search Shows, Animation...",
        prefixIcon: Icon(Icons.search_rounded),
        filled: true,
        fillColor: darkGrey,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: red),
        ),
      ),
    );
  }
}
