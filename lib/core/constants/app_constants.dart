import 'package:seven/app/app.dart';

class AppConstants {
  // ROUTES
  static final APP_ROUTES = [
    ScreenRoutes(path: "/", child: const OnboadingScreen()),
    ScreenRoutes(path: "/movies", child: const Movies())
  ];

  // ONBOARDING
  static const ONBOARDING_TEXT = [
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
      // 'description':
      //     "From breathtaking anime adventures to gripping movie sagas and story-driven games\n— step into a world where every journey feels alive,\nand every scene holds a new chapter."
    },
    {
      'heading':
          "Not all gifts are\nwrapped in\nribbons.\nSome are born\nunder a\nblood-lit moon.",
      'description':
          "Every story has a beginning, and this\none starts where the city ends\n— in the silence of the night."
    },
  ];
}
