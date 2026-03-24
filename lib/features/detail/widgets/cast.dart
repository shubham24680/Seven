import 'package:seven/app/app.dart';

Widget buildHeader(String value) {
  final sidePadding = AppConstants.SIDE_PADDING;
  return CustomText(text: value, family: AppFonts.STAATLICHES, size: 0.03.sh)
      .paddingFromLTRB(
          left: sidePadding, right: sidePadding, bottom: 0.15 * sidePadding);
}

Widget buildCastAndCrew(CastAndCrew castOrCrew) {
  final name = castOrCrew.name ?? "";
  final errorWidget = name.isEmpty
      ? null
      : Container(
          height: 75.w,
          width: 75.w,
          color: AppColors.black2,
          alignment: Alignment.center,
          child: CustomText(
              family: AppFonts.STAATLICHES,
              text: name.split(" ").map((e) => e.substring(0, 1)).join(""),
              size: 24.w,
              weight: FontWeight.w900));

  return Column(children: [
    CustomImage(
        imageType: ImageType.REMOTE,
        imageUrl: getImageUrl(castOrCrew.profilePath),
        errorWidget: errorWidget,
        height: 75.w,
        width: 75.w,
        borderRadius: BorderRadius.circular(1000.r)),
    SizedBox(height: 8.w),
    CustomText(
        text: name,
        size: 12.w,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        align: TextAlign.center,
        weight: FontWeight.bold),
    SizedBox(height: 4.w),
    CustomText(
        text: castOrCrew.character ?? castOrCrew.job ?? "",
        color: AppColors.lightSteel1.withAlpha(150),
        size: 10.w,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        align: TextAlign.center)
  ]);
}

Widget buildCastAndCrewLoading() {
  return Column(mainAxisSize: MainAxisSize.min, children: [
    customShimmer(height: 75.w, width: 75.w, borderRadius: 1.sh),
    SizedBox(height: 8.w),
    customShimmer(height: 8.w, width: 75.w, borderRadius: 0.01.sh),
    SizedBox(height: 4.w),
    customShimmer(height: 8.w, width: 60.w, borderRadius: 0.01.sh)
  ]);
}
