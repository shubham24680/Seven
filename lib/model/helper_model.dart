import 'package:seven/app/app.dart';

class ScreenRoutes {
  final String path;
  final Widget child;

  ScreenRoutes({required this.path, required this.child});
}

class BottomNavigation {
  final String icon;
  final Widget screen;

  BottomNavigation({required this.icon, required this.screen});
}
