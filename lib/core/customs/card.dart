import 'package:seven/app/app.dart';

enum CardOrientation { POTRAIT, LANDSCAPE }

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.orientation = CardOrientation.LANDSCAPE,
    required this.result,
  });

  final CardOrientation orientation;
  final Result? result;

  @override
  Widget build(BuildContext context) {
    final aspectRatio = orientation == CardOrientation.POTRAIT
        ? AppConstants.CARD_RATIO_PORTRAIT
        : AppConstants.CARD_RATIO_LANDSCAPE;
    final height = orientation == CardOrientation.POTRAIT ? 0.32.sh : 0.17.sh;
    final maxLines = orientation == CardOrientation.POTRAIT ? 2 : 1;
    final width = height * aspectRatio;
    final borderRadius =
        height * (orientation == CardOrientation.POTRAIT ? 0.05 : 0.1);
    final imagePath = orientation == CardOrientation.POTRAIT
        ? result?.posterPath ?? ""
        : result?.backdropPath ?? "";
    final textSize =
        height * (orientation == CardOrientation.POTRAIT ? 0.05 : 0.11);

    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomImage(
            imageType: ImageType.REMOTE,
            imageUrl: ApiConstants.IMAGE_PATH + imagePath,
            borderRadius: BorderRadius.circular(borderRadius),
            placeholder: customShimmer(
                height: height, width: width, borderRadius: borderRadius),
          ),
          if (result?.title != null)
            blurEffect(
                3,
                Container(
                  height: height * 0.2,
                  width: width,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.SIDE_PADDING),
                  decoration: BoxDecoration(
                    color: AppColors.black5.withAlpha(70),
                  ),
                  child: CustomText(
                    text: result?.title ?? "",
                    size: textSize,
                    align: TextAlign.center,
                    weight: FontWeight.w900,
                    maxLines: maxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(borderRadius))),
        ],
      ),
    );
  }
}
