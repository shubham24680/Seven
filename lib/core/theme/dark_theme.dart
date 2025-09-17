import 'package:seven/app/app.dart';

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.black3,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.lightSteel9,
  ),
  colorScheme: const ColorScheme.dark(
    primary: AppColors.lightSteel1,
    secondary: AppColors.vividNightfall4,
    tertiary: AppColors.lightSteel9,
  ),
);
