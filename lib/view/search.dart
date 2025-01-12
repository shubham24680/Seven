import 'package:flutter/material.dart';
import 'package:netflix/core/utils/texts.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Quicksand(text: "Search"),
      ),
      body: Center(
        child: Quicksand(text: "Search"),
      ),
    );
  }
}
