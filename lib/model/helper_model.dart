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

class ErrorData {
  final String title, subtitle, image, buttonText;

  ErrorData(
      {required this.title,
      required this.subtitle,
      required this.image,
      required this.buttonText});
}

class ProfileModel {
  final String icon, title;

  ProfileModel({required this.icon, required this.title});
}
