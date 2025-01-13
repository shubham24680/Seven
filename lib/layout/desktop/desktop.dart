import 'package:flutter/material.dart';
import 'package:netflix/core/utils/logo.dart';
import 'package:netflix/layout/desktop/home.dart';
import 'package:netflix/layout/desktop/search.dart';
import 'package:netflix/view_model/left_navigation_button.dart';
import 'package:netflix/view_model/shows_provider.dart';
import 'package:provider/provider.dart';

class DesktopLayout extends StatelessWidget {
  DesktopLayout({super.key});

  final List<Widget> screen = [
    const DesktopHome(),
    const DesktopSearch(),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: logo,
                  ),
                  LeftNavigationButton(),
                ],
              ),
              SizedBox(
                width: size.width - 40,
                child: Consumer<ShowsProvider>(
                  builder: (_, value, __) {
                    return screen[value.currentIndex];
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
