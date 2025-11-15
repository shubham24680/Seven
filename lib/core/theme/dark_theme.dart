import 'package:seven/app/app.dart';

final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.black3,
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.black3),
    colorScheme: const ColorScheme.dark(
        primary: AppColors.lightSteel1,
        secondary: AppColors.vividNightfall4,
        tertiary: AppColors.lightSteel9),
    textSelectionTheme: TextSelectionThemeData(
        selectionColor: AppColors.vividNightfall4.withAlpha(70),
        selectionHandleColor: AppColors.vividNightfall4));
