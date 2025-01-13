import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:netflix/routes/routes.dart';
import 'package:netflix/theme/dark.dart';
import 'package:netflix/view_model/shows_provider.dart';
import 'package:netflix/view_model/bottom_navigation_button.dart';

import 'package:netflix/view/home/home.dart';
import 'package:netflix/view/search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShowsProvider(),
      child: MaterialApp(
        routes: routes,
        theme: dark,
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            body: Body(),
            bottomNavigationBar: BottomNavigationButton(),
          ),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  Body({super.key});

  final List<Widget> screen = [
    const Home(),
    const Search(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ShowsProvider>(
      builder: (_, value, __) {
        return screen[value.currentIndex];
      },
    );
  }
}
