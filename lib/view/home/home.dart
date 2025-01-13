import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:netflix/view/home/heading.dart';
import 'package:provider/provider.dart';

import 'package:netflix/view_model/shows_provider.dart';
import 'package:netflix/view_model/shows_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ShowsProvider>(context, listen: false).fetchCategories();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: SvgPicture.asset('assets/icons/netflix.svg', height: 30),
          ),
          Heading(text: "All Shows"),
          Consumer<ShowsProvider>(
            builder: (_, value, __) {
              final shows = value.shows;
              log(shows.toString());
              return ShowList(shows: shows);
            },
          ),
          Heading(text: "Today's Top Picks for You"),
          Consumer<ShowsProvider>(
            builder: (_, value, __) {
              final shows = value.shows;
              log(shows.toString());
              return ShowList(shows: shows);
            },
          ),
          Heading(text: "Continue Watching for Alex"),
          Consumer<ShowsProvider>(
            builder: (_, value, __) {
              final shows = value.shows;
              log(shows.toString());
              return ShowList(shows: shows);
            },
          ),
        ],
      ),
    );
  }
}
