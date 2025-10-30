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
    ScreenRoutes(path: "/collection", child: const CollectionScreen()),
  ];

  // ONBOARDING
  static const List<Map<String, String>> ONBOARDING_TEXT = [
    {
      'heading':
          "When the Sun Sets\nand the\nWorld Grows Quiet,\nNew Journeys Begin\nin Stories\nYet Untold.",
      'description':
          "Discover adventures that blur the line\nbetween reality and imagination\n— stories you can see, feel, and live."
    },
    {
      'heading':
          "Beyond Screens,\nInto Worlds\nWhere Stories Breathe\nand\nAdventures\nNever End.",
      'description':
          "From anime adventures to movie sagas and games\n— step into worlds where every journey feels alive.\nand every scene holds a new chapter."
    },
    {
      'heading':
          "Not all gifts are\nwrapped in\nribbons.\nSome are born\nunder a\nblood-lit moon.",
      'description':
          "Every story has a beginning, and this\none starts where the city ends\n— in the silence of the night."
    },
  ];

  // COLLECTION
  static final List<String> COLLECTIONS = [
    "Top 20 Movies",
    "New Release",
    "Upcoming",
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
