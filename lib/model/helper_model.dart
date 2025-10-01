import 'package:seven/app/app.dart';

class HelperModel {
  final String? string1, string2, string3, string4;
  final Widget? widget1;

  HelperModel(
      {this.string1, this.string2, this.string3, this.string4, this.widget1});
}

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
