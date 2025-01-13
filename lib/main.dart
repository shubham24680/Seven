import 'package:flutter/material.dart';
import 'package:netflix/layout/desktop/desktop.dart';
import 'package:netflix/layout/layout.dart';
import 'package:netflix/layout/mobile/mobile.dart';
import 'package:netflix/layout/tablet/tablet.dart';
import 'package:netflix/routes/routes.dart';
import 'package:netflix/theme/dark.dart';
import 'package:netflix/view_model/search_provider.dart';
import 'package:netflix/view_model/shows_provider.dart';
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
      child: MaterialApp(
        routes: routes,
        theme: dark,
        debugShowCheckedModeBanner: false,
        home: ResponsiveLayout(
          mobileLayout: MobileLayout(),
          tabletLayout: TabletLayout(),
          desktopLayout: DesktopLayout(),
        ),
      ),
    );
  }
}
