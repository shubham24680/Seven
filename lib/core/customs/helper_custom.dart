import 'dart:developer';
import 'dart:ui';
import 'package:seven/app/app.dart';

// BLUR
Widget blurEffect(double blurValue, Widget child,
    {BorderRadius borderRadius = BorderRadius.zero}) {
  return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
          child: child));
}

// SHIMMER
Widget customShimmer({double? height, double? width, double? borderRadius}) {
  return Shimmer.fromColors(
    baseColor: AppColors.black2,
    highlightColor: AppColors.black1,
    child: Container(
      height: height ?? 1.sh,
      width: width ?? 1.sw,
      decoration: BoxDecoration(
        color: AppColors.lightSteel1,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),
    ),
  );
}

// APPBAR
AppBar customAppBar(void Function()? onPressed, String appBarTitle) {
  final leading = CustomButton(
      buttonType: ButtonType.ICON,
      onPressed: onPressed,
      icon: AppSvgs.ARROW_LEFT,
      forgroundColor: AppColors.lightSteel1,
      backgroundColor: AppColors.transparent);
  final title = CustomText(
      text: appBarTitle, family: AppFonts.STAATLICHES, size: 0.03.sh);

  return AppBar(
    leading: leading,
    title: title,
    flexibleSpace:
        blurEffect(20.0, Container(color: AppColors.black3.withAlpha(200))),
  );
}

// Bottom Sheet
void customBottomSheet(BuildContext context, String title, Widget child,
    {Color? backgroundColor}) {
  final borderRadius = BorderRadius.vertical(top: Radius.circular(0.02.sh));
  final sheetColor = AppColors.lightSteel1;

  showModalBottomSheet(
      context: context,
      backgroundColor: backgroundColor ?? sheetColor.withAlpha(10),
      barrierColor: AppColors.transparent,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      isScrollControlled: true,
      builder: (context) => blurEffect(
          20.0,
          Column(mainAxisSize: MainAxisSize.min, children: [
            CustomText(
              text: title,
              family: AppFonts.STAATLICHES,
              color: sheetColor.withAlpha(150),
            ),
            Divider(color: sheetColor.withAlpha(40)),
            child
          ]).paddingAll(AppConstants.SIDE_PADDING),
          borderRadius: borderRadius));
}

Future<void> customUrlLauncher(String url) async {
  log("Url -> $url");
  final uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    log("Error while launch url");
  }
}
