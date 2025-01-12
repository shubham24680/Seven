import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:netflix/view_model/show_list.dart';

import 'package:netflix/core/utils/colors.dart';
import 'package:netflix/view/home/heading.dart';
import 'package:netflix/view_model/show_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SvgPicture.asset(
                  'assets/icons/netflix.svg',
                  height: 30,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/search'),
                child: Container(
                  height: 40,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: darkGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: grey),
                      SizedBox(width: 10),
                      Text(
                        "Search...",
                        style: TextStyle(color: grey),
                      ),
                    ],
                  ),
                ),
              ),
              Heading(text: 'Shows'),
              Consumer<ShowProvider>(builder: (_, value, __) {
                final drama = value.drama;
                print(drama.toString());
                return ShowList(genre: drama);
                // ShowList(),
              }),
              // SizedBox(height: 20),
              // Heading(text: 'Sports'),
              // ShowList(),
              // Consumer<HomeBookFetch>(builder: (context, homeBookFetch, child) {
              //   final mangaBooks = homeBookFetch.mangaBooks;
              //   return Booklist(bookimgs: mangaBooks);
              // }),
              // SizedBox(height: 20),
              // Heading(text: 'Thriller'),
              // ShowList(),
            ],
          ),
        ),
      ),
    );
  }
}
