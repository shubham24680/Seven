import 'dart:ui';
import 'package:seven/app/app.dart';

Widget blurEffect(double blurValue, Widget child,
    {BorderRadius borderRadius = BorderRadius.zero}) {
  return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
          child: child));
}

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
