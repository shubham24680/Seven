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
PreferredSizeWidget customAppBar(
    void Function()? onPressed, String appBarTitle) {
  final leading = CustomButton(
      buttonType: ButtonType.ICON,
      onPressed: onPressed,
      icon: AppSvgs.ARROW_LEFT,
      forgroundColor: AppColors.lightSteel1,
      backgroundColor: AppColors.transparent);
  final title = CustomText(
      text: appBarTitle, family: AppFonts.STAATLICHES, size: 0.03.sh);

  return AppBar(
      backgroundColor: AppColors.transparent,
      toolbarHeight: 50,
      centerTitle: true,
      leading: leading,
      title: title);
}
