import 'package:seven/app/app.dart';

class AppConstants {
  static const SIDE_PADDING = 20.0;
  static const CARD_RATIO_LANDSCAPE = 1.78;
  static const CARD_RATIO_PORTRAIT = 0.67;

  // ROUTES
  static final List<ScreenRoutes> APP_ROUTES = [
    ScreenRoutes(path: "/", child: const Shows()),
    ScreenRoutes(path: "/onboarding", child: const OnboadingScreen()),
    ScreenRoutes(path: "/notification", child: const NotificationScreen()),
    ScreenRoutes(path: "/editProfile", child: const EditProfileScreen()),
    ScreenRoutes(
        path: "/notificationSettings",
        child: const NotificationSettingsScreen()),
    ScreenRoutes(path: "/help", child: const HelpScreen()),
  ];

  // ONBOARDING
  static List<HelperModel> ONBOARDING = [
    HelperModel(
        string1: AppImages.ONBOARDING_1,
        string2:
            "When the Sun Sets\nand the\nWorld Grows Quiet,\nNew Journeys Begin\nin Stories\nYet Untold.",
        string3:
            "Discover adventures that blur the line\nbetween reality and imagination\n— stories you can see, feel, and live."),
    HelperModel(
        string1: AppImages.ONBOARDING_2,
        string2:
            "Beyond Screens,\nInto Worlds\nWhere Stories Breathe\nand\nAdventures\nNever End.",
        string3:
            "Discover adventures that blur the line\nbetween reality and imagination\n— stories you can see, feel, and live."),
  ];

  // PROFILE
  static List<HelperModel> PROFILE = [
    HelperModel(
        string1: AppSvgs.NOTIFICATION,
        string2: "Notifications",
        string3: "/notificationSettings"),
    HelperModel(string1: AppSvgs.HELP, string2: "Help", string3: "/help"),
  ];

  static List<HelperModel> GENDER = [
    HelperModel(string1: "Male", string2: AppSvgs.MALE),
    HelperModel(string1: "Female", string2: AppSvgs.FEMALE),
  ];

  // ERROR
  static HelperModel ERRORDATA = HelperModel(
      string1: "OH NO!",
      string2: "No internet connection.\nCheck your network and try again.",
      string3: AppSvgs.NO_CONNECTION,
      string4: "Try again",
      string5: "Back");
}
