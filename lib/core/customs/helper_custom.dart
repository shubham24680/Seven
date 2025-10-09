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
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightSteel1,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),
    ),
  );
}

// TAG
Widget customTag(String icon, String value) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 0.02.sw, vertical: 0.005.sh),
    decoration: BoxDecoration(
      color: AppColors.vividNightfall4,
      borderRadius: BorderRadius.circular(0.02.sh),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomImage(
          imageType: ImageType.SVG_LOCAL,
          imageUrl: icon,
          height: 0.02.sh,
          color: AppColors.lightSteel1,
        ),
        const SizedBox(width: 5),
        CustomText(
          text: value,
          size: 0.015.sh,
        )
      ],
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
