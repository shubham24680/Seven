import 'package:flutter/material.dart';
import 'package:seven/core/utils/logo.dart';
import 'package:seven/app/desktop/home.dart';
import 'package:seven/app/desktop/search.dart';
import 'package:seven/features/view_model/left_navigation_button.dart';
import 'package:seven/features/view_model/shows_provider.dart';
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
