import 'package:flutter/material.dart';
import 'package:netflix/view_model/search_list.dart';
import 'package:netflix/view_model/text_field.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          Editor(),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossCount = 2;
              if (constraints.maxWidth < 500) {
                crossCount = 2;
              } else if (constraints.maxWidth < 1100) {
                crossCount = 4;
              }
              return SearchList(crossCount: crossCount);
            },
          )
        ],
      ),
    );
  }
}
