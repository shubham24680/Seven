import 'package:seven/app/app.dart';

class AppConstants {
  static const SIDE_PADDING = 15.0;
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
    ScreenRoutes(
        path: "/searchCollection", child: const SearchCollectionScreen()),
    ScreenRoutes(path: "/help", child: const HelpScreen()),
  ];

  // ONBOARDING
  static List<HelperModel> ONBOARDING = [
    HelperModel(
        string1: AppImages.ONBOARDING_1,
        string2:
            "In the Shadows\nof Power,\nEven Light\nFinds Its Path.\nEvery Choice Forged\nin Fire and Fate.",
        string3:
            "Step into worlds where destiny collides\nwith courage — where every story\nhas a light waiting to rise."),
    HelperModel(
        string1: AppImages.ONBOARDING_2,
        string2:
            "From the Ashes of Darkness,\nHope Ignites Again.\nBalance Lives\nWhere Heroes Dare to Dream.",
        string3:
            "Discover tales that transcend time —\nwhere legends fight not for victory,\nbut for the soul of the galaxy.")
  ];

  static List<Result> GENRES = [
    Result(
        id: 28,
        backdropPath: AppImages.ACTION,
        posterPath: AppImages.ACTION,
        title: "Action"),
    Result(
        id: 16,
        backdropPath: AppImages.ANIMATION,
        posterPath: AppImages.ANIMATION,
        title: "Animation"),
    Result(
        id: 18,
        backdropPath: AppImages.DRAMA,
        posterPath: AppImages.DRAMA,
        title: "Drama"),
    Result(
        id: 10751,
        backdropPath: AppImages.FAMILY,
        posterPath: AppImages.FAMILY,
        title: "Family"),
    Result(
        id: 14,
        backdropPath: AppImages.FANTASY,
        posterPath: AppImages.FANTASY,
        title: "Fantasy"),
    Result(
        id: 36,
        backdropPath: AppImages.HISTORY,
        posterPath: AppImages.HISTORY,
        title: "History"),
    Result(
        id: 27,
        backdropPath: AppImages.HORROR,
        posterPath: AppImages.HORROR,
        title: "Horror"),
    Result(
        id: 9648,
        backdropPath: AppImages.MYSTERY,
        posterPath: AppImages.MYSTERY,
        title: "Mystery"),
    Result(
        id: 878,
        backdropPath: AppImages.SCIENCE_FICTION,
        posterPath: AppImages.SCIENCE_FICTION,
        title: "Science Fiction"),
    Result(
        id: 53,
        backdropPath: AppImages.THRILLER,
        posterPath: AppImages.THRILLER,
        title: "Thriller")
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

  // NETWORK ERROR (Default
    static HelperModel ERRORDATA = HelperModel(
      string1: "OH NO!",
      string2: "No internet connection.\nCheck your network and try again.",
      string3: AppSvgs.NO_CONNECTION,
      string4: "Try again",
      string5: "Back");
}

  // NO DATA ERROR
  static HelperModel NO_DATA_ERRORDATA = HelperModel(
      string1: "NOTHING HERE!",
      string2: "No data available at the moment.\nPlease check back later.",
      string3: AppSvgs.NO_RESULT,
      string4: "Refresh",
      string5: "Back");

  // SERVER ERROR
  static HelperModel SERVER_ERRORDATA = HelperModel(
      string1: "SERVER ERROR!",
      string2: "Something went wrong on our end.\nPlease try again later.",
      string3: AppSvgs.NO_CONNECTION,
      string4: "Retry",
      string5: "Back");
}

