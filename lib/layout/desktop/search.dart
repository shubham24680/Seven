import 'package:flutter/material.dart';
import 'package:netflix/view_model/search_list.dart';
import 'package:netflix/view_model/text_field.dart';

class DesktopSearch extends StatelessWidget {
  const DesktopSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          Editor(),
          SearchList(crossCount: 8),
        ],
      ),
    );
  }
}
