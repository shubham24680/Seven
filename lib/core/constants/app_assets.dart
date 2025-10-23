import 'package:seven/app/app.dart';

class AppAssets {
  static final List<BottomNavigation> BOTTOM_NAVIGATION_ICONS = [
    BottomNavigation(icon: AppSvgs.HOME, screen: HomeScreen()),
    // BottomNavigation(icon: AppSvgs.SEARCH, screen: const SearchScreen()),
    BottomNavigation(icon: AppSvgs.PROFILE, screen: const ProfileScreen()),
  ];

  static const List<String> ONBOARDING_IMAGES = [
    AppImages.ONBOARDING_1,
    AppImages.ONBOARDING_2,
    AppImages.ONBOARDING_3
  ];

  static const List<String> AVATARS = [
    AppImages.AVATAR_1,
    AppImages.AVATAR_2,
  ];
}

class AppImages {
  static const AVATAR_1 = "assets/avatars/avatar (1).jpg";
  static const AVATAR_2 = "assets/avatars/avatar (2).jpg";
  static const ONBOARDING_1 = "assets/images/onboarding (1).png";
  static const ONBOARDING_2 = "assets/images/onboarding (2).png";
  static const ONBOARDING_3 = "assets/images/onboarding (3).png";
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
