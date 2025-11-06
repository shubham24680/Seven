import 'package:seven/app/app.dart';

class AppAssets {
  static final List<BottomNavigation> BOTTOM_NAVIGATION_ICONS = [
    BottomNavigation(icon: AppSvgs.HOME, screen: HomeScreen()),
    // BottomNavigation(icon: AppSvgs.SEARCH, screen: const SearchScreen()),
    BottomNavigation(icon: AppSvgs.PROFILE, screen: const ProfileScreen()),
  ];
}

class AppImages {
  static final AVATARS =
      List.generate(10, (index) => "assets/avatars/avatar (${index + 1}).jpeg");
  static const GENRE_CARD_1 = "assets/images/genre_card (1).jpg";
  static const GENRE_CARD_2 = "assets/images/genre_card (2).jpg";
  static const ONBOARDING_1 = "assets/images/onboarding (1).jpg";
  static const ONBOARDING_2 = "assets/images/onboarding (2).jpg";
  static const PLACEHOLDER = "assets/images/placeholder_image.png";
}

class AppSvgs {
  static const ARROW_LEFT = "assets/icons/outlined_icons/arrow_left.svg";
  static const ARROW_RIGHT = "assets/icons/outlined_icons/arrow_right.svg";
  static const ADD_TO_FAVOURITE = "assets/icons/outlined_icons/add.svg";
  static const CALENDAR = "assets/icons/outlined_icons/calendar.svg";
  static const FEMALE = "assets/icons/outlined_icons/female.svg";
  static const HOME = "assets/icons/filled_icons/home.svg";
  static const HELP = "assets/icons/outlined_icons/help.svg";
  static const LINK = "assets/icons/outlined_icons/link.svg";
  static const MALE = "assets/icons/outlined_icons/male.svg";
  static const NOTIFICATION = "assets/icons/outlined_icons/notification.svg";
  static const NO_INTERNET = "assets/images/no_internet.svg";
  static const NO_CONNECTION = "assets/images/no_connection.svg";
  static const PROFILE = "assets/icons/filled_icons/profile.svg";
  static const PLAY = "assets/icons/outlined_icons/play.svg";
  static const REMOVE_TO_FAVOURITE = "assets/icons/filled_icons/remove.svg";
  static const STAR = "assets/icons/filled_icons/star.svg";
  static const SEARCH = "assets/icons/filled_icons/search.svg";
  static const SAVE = "assets/icons/filled_icons/save.svg";
}

class AppGifs {
  static const NO_INTERNET_GIF = "assets/gifs/no_internet.gif";
}

class AppFonts {
  static const POPPINS = 'poppins';
  static const STAATLICHES = 'staatliches';
}
