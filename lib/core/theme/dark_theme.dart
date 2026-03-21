import 'package:seven/app/app.dart';

final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.black3,
    canvasColor: Colors.transparent,
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.transparent,
        surfaceTintColor: AppColors.transparent,
        centerTitle: true),
    colorScheme: const ColorScheme.dark(
        primary: AppColors.lightSteel1,
        secondary: AppColors.vividNightfall4,
        tertiary: AppColors.lightSteel9),
    textSelectionTheme: TextSelectionThemeData(
        selectionColor: AppColors.vividNightfall4.withAlpha(70),
        selectionHandleColor: AppColors.vividNightfall4));

// import 'dart:ui';
// import 'package:seven/app/app.dart';
//
// final ThemeData darkTheme = ThemeData(
//   scaffoldBackgroundColor: AppColors.black3,
//   canvasColor: Colors.transparent,
//
//   // ─── COLOR SCHEME ───────────────────────────────────────────
//   colorScheme: const ColorScheme.dark(
//     primary: AppColors.vividNightfall4,
//     onPrimary: AppColors.lightSteel1,
//     secondary: AppColors.vividNightfall3,
//     onSecondary: AppColors.lightSteel1,
//     surface: Colors.transparent,
//     onSurface: AppColors.lightSteel1,
//     onSurfaceVariant: AppColors.lightSteel5,  // hints / placeholders
//     outline: AppColors.lightSteel6,
//     error: AppColors.red2,
//     onError: AppColors.lightSteel1,
//   ),
//
//   // ─── APPBAR ─────────────────────────────────────────────────
//   appBarTheme: const AppBarTheme(
//     backgroundColor: AppColors.transparent,
//     surfaceTintColor: AppColors.transparent,
//     centerTitle: true,
//     elevation: 0,
//     titleTextStyle: TextStyle(
//       color: AppColors.lightSteel1,
//       fontSize: 18,
//       fontWeight: FontWeight.w600,
//     ),
//     iconTheme: IconThemeData(color: AppColors.lightSteel1),
//   ),
//
//   // ─── TEXT ────────────────────────────────────────────────────
//   textTheme: const TextTheme(
//     // Display
//     displayLarge:  TextStyle(color: AppColors.lightSteel1, fontWeight: FontWeight.bold),
//     displayMedium: TextStyle(color: AppColors.lightSteel1, fontWeight: FontWeight.bold),
//     displaySmall:  TextStyle(color: AppColors.lightSteel1, fontWeight: FontWeight.bold),
//     // Headline
//     headlineLarge:  TextStyle(color: AppColors.lightSteel1, fontWeight: FontWeight.w700),
//     headlineMedium: TextStyle(color: AppColors.lightSteel1, fontWeight: FontWeight.w600),
//     headlineSmall:  TextStyle(color: AppColors.lightSteel1, fontWeight: FontWeight.w600),
//     // Title
//     titleLarge:  TextStyle(color: AppColors.lightSteel1, fontWeight: FontWeight.w600),
//     titleMedium: TextStyle(color: AppColors.lightSteel2, fontWeight: FontWeight.w500),
//     titleSmall:  TextStyle(color: AppColors.lightSteel3, fontWeight: FontWeight.w500),
//     // Body
//     bodyLarge:  TextStyle(color: AppColors.lightSteel1),
//     bodyMedium: TextStyle(color: AppColors.lightSteel2),
//     bodySmall:  TextStyle(color: AppColors.lightSteel5),  // secondary/hints
//     // Label
//     labelLarge:  TextStyle(color: AppColors.lightSteel1, fontWeight: FontWeight.w600),
//     labelMedium: TextStyle(color: AppColors.lightSteel4),
//     labelSmall:  TextStyle(color: AppColors.lightSteel5),
//   ),
//
//   textSelectionTheme: TextSelectionThemeData(
//     selectionColor: AppColors.vividNightfall4.withAlpha(70),
//     selectionHandleColor: AppColors.vividNightfall4,
//     cursorColor: AppColors.vividNightfall4,
//   ),
//
//   // ─── ELEVATED BUTTON ────────────────────────────────────────
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ButtonStyle(
//       backgroundColor: WidgetStateProperty.resolveWith((states) {
//         if (states.contains(WidgetState.disabled)) {
//           return AppColors.black5.withAlpha(20);
//         }
//         return AppColors.black5.withAlpha(20); // blur overlay — pair with BackdropFilter
//       }),
//       foregroundColor: WidgetStateProperty.all(AppColors.lightSteel1),
//       overlayColor: WidgetStateProperty.all(
//         AppColors.vividNightfall4.withAlpha(30),
//       ),
//       elevation: WidgetStateProperty.all(0),
//       side: WidgetStateProperty.resolveWith((states) {
//         if (states.contains(WidgetState.focused) ||
//             states.contains(WidgetState.pressed)) {
//           return const BorderSide(color: AppColors.vividNightfall4, width: 1.5);
//         }
//         return const BorderSide(color: AppColors.lightSteel6, width: 1);
//       }),
//       shape: WidgetStateProperty.all(
//         RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//       ),
//       padding: WidgetStateProperty.all(
//         const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//       ),
//     ),
//   ),
//
//   // ─── TEXT BUTTON ────────────────────────────────────────────
//   textButtonTheme: TextButtonThemeData(
//     style: ButtonStyle(
//       foregroundColor: WidgetStateProperty.resolveWith((states) {
//         if (states.contains(WidgetState.disabled)) return AppColors.lightSteel6;
//         return AppColors.vividNightfall2;
//       }),
//       overlayColor: WidgetStateProperty.all(
//         AppColors.vividNightfall4.withAlpha(20),
//       ),
//       textStyle: WidgetStateProperty.all(
//         const TextStyle(fontWeight: FontWeight.w600),
//       ),
//     ),
//   ),
//
//   // ─── INPUT / TEXTFORMFIELD ───────────────────────────────────
//   inputDecorationTheme: InputDecorationTheme(
//     filled: true,
//     fillColor: AppColors.black5.withAlpha(20),
//     hintStyle: const TextStyle(color: AppColors.lightSteel6),
//     labelStyle: const TextStyle(color: AppColors.lightSteel5),
//     floatingLabelStyle: const TextStyle(color: AppColors.vividNightfall2),
//     prefixIconColor: AppColors.lightSteel5,
//     suffixIconColor: AppColors.lightSteel5,
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(14),
//       borderSide: const BorderSide(color: AppColors.lightSteel6, width: 1),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(14),
//       borderSide: const BorderSide(color: AppColors.lightSteel7, width: 1),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(14),
//       borderSide: const BorderSide(color: AppColors.vividNightfall4, width: 1.5),
//     ),
//     errorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(14),
//       borderSide: const BorderSide(color: AppColors.red2, width: 1),
//     ),
//     focusedErrorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(14),
//       borderSide: const BorderSide(color: AppColors.red1, width: 1.5),
//     ),
//   ),

//   // ─── BOTTOM NAVIGATION BAR ──────────────────────────────────
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//     backgroundColor: AppColors.black5.withAlpha(20), // pair with BackdropFilter
//     selectedItemColor: AppColors.vividNightfall2,
//     unselectedItemColor: AppColors.lightSteel6,
//     showUnselectedLabels: true,
//     type: BottomNavigationBarType.fixed,
//     elevation: 0,
//   ),
//
//   navigationBarTheme: NavigationBarThemeData(
//     backgroundColor: AppColors.black5.withAlpha(20),
//     surfaceTintColor: Colors.transparent,
//     indicatorColor: AppColors.vividNightfall4.withAlpha(60),
//     iconTheme: WidgetStateProperty.resolveWith((states) {
//       if (states.contains(WidgetState.selected)) {
//         return const IconThemeData(color: AppColors.vividNightfall2);
//       }
//       return const IconThemeData(color: AppColors.lightSteel6);
//     }),
//     labelTextStyle: WidgetStateProperty.resolveWith((states) {
//       if (states.contains(WidgetState.selected)) {
//         return const TextStyle(
//           color: AppColors.vividNightfall2,
//           fontWeight: FontWeight.w600,
//           fontSize: 12,
//         );
//       }
//       return const TextStyle(color: AppColors.lightSteel6, fontSize: 12);
//     }),
//   ),
//
//   // ─── SNACKBAR ───────────────────────────────────────────────
//   snackBarTheme: SnackBarThemeData(
//     backgroundColor: AppColors.black5.withAlpha(200),
//     contentTextStyle: const TextStyle(color: AppColors.lightSteel1),
//     actionTextColor: AppColors.vividNightfall2,
//     behavior: SnackBarBehavior.floating,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     elevation: 0,
//   ),
//
//   // ─── DIALOG ─────────────────────────────────────────────────
//   dialogTheme: DialogTheme(
//     backgroundColor: AppColors.black3.withAlpha(180),
//     surfaceTintColor: Colors.transparent,
//     elevation: 0,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//     titleTextStyle: const TextStyle(
//       color: AppColors.lightSteel1,
//       fontSize: 18,
//       fontWeight: FontWeight.w600,
//     ),
//     contentTextStyle: const TextStyle(
//       color: AppColors.lightSteel3,
//       fontSize: 14,
//     ),
//   ),
//
//   // ─── BOTTOM SHEET ────────────────────────────────────────────
//   bottomSheetTheme: BottomSheetThemeData(
//     backgroundColor: AppColors.black3.withAlpha(180),
//     surfaceTintColor: Colors.transparent,
//     modalBackgroundColor: AppColors.black3.withAlpha(200),
//     elevation: 0,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//     ),
//   ),
// );
