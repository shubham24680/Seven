import 'package:flutter/material.dart';
import 'package:netflix/view/home/heading.dart';
import 'package:netflix/view/home/home_search.dart';
import 'package:netflix/view_model/shows_list.dart';
import 'package:netflix/view_model/shows_provider.dart';
import 'package:provider/provider.dart';

class DesktopHome extends StatelessWidget {
  const DesktopHome({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ShowsProvider>(context, listen: false).fetchCategories();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Align(
            alignment: Alignment.centerRight,
            child: HomeSearch(),
          ),
        ),
        Heading(text: "All Shows"),
        ShowList(),
        Heading(text: "Today's Top Picks for You"),
        ShowList(),
        Heading(text: "Continue Watching for Alex"),
        ShowList(),
      ],
    );
  }
}
