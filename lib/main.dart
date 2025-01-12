import 'package:flutter/material.dart';
import 'package:netflix/routes/routes.dart';
import 'package:netflix/theme/dark.dart';
import 'package:netflix/view/home/home.dart';
import 'package:netflix/view_model/show_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ShowProvider(),
        ),
      ],
      child: MaterialApp(
        routes: routes,
        theme: dark,
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
