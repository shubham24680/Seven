import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:netflix/core/utils/colors.dart';
import 'package:netflix/view_model/shows_provider.dart';
import 'package:netflix/view_model/shows_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ShowsProvider>(context, listen: false).fetchCategories();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: SvgPicture.asset(
              'assets/icons/netflix.svg',
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/search'),
              padding: EdgeInsets.only(right: 15),
              icon: Icon(Icons.search_rounded, color: white),
            ),
          ],
        ),
        body: Consumer<ShowsProvider>(
          builder: (_, value, __) {
            final shows = value.shows;
            log(shows.toString());
            return ShowList(shows: shows);
          },
        ),
      ),
    );
  }
}
