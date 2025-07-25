import 'package:flutter/material.dart';
import 'package:seven/core/routes/routes.dart';
import 'package:seven/core/theme/dark_theme.dart';
import 'package:seven/features/view_model/search_provider.dart';
import 'package:seven/features/view_model/shows_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ShowsProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
      ],
      child: MaterialApp.router(
        routerConfig: routes,
        theme: dark,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
