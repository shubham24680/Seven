import 'package:seven/app/app.dart';

Widget buildHeader(String value) {
  final sidePadding = AppConstants.SIDE_PADDING;
  return CustomText(text: value, family: AppFonts.STAATLICHES, size: 0.03.sh)
      .paddingFromLTRB(
          left: sidePadding, right: sidePadding, bottom: 0.15 * sidePadding);
}

Widget buildCastAndCrew(CastAndCrew castOrCrew) {
  return Column(children: [
    CustomImage(
        imageType: ImageType.REMOTE,
        imageUrl: getImageUrl(castOrCrew.profilePath),
        height: 0.2.sw,
        width: 0.2.sw,
        borderRadius: BorderRadius.circular(1.sh)),
    SizedBox(height: 0.01.sh),
    CustomText(
        text: castOrCrew.name ?? "",
        size: 0.035.sw,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        align: TextAlign.center,
        weight: FontWeight.bold),
    SizedBox(height: 0.005.sh),
    CustomText(
        text: castOrCrew.character ?? castOrCrew.job ?? "",
        color: AppColors.lightSteel1.withAlpha(150),
        size: 0.03.sw,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        align: TextAlign.center)
  ]);
}

Widget buildCastAndCrewLoading() {
  return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    customShimmer(height: 0.2.sw, width: 0.2.sw, borderRadius: 1.sh),
    customShimmer(height: 0.015.sh, width: 0.2.sw, borderRadius: 0.01.sh),
    customShimmer(height: 0.015.sh, width: 0.2.sw, borderRadius: 0.01.sh)
  ]);
}
