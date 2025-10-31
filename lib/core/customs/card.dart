import 'package:seven/app/app.dart';

enum CardOrientation { POTRAIT, LANDSCAPE }

enum CardType { SHOWS, GENRE }

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key,
      this.cardType = CardType.SHOWS,
      this.orientation = CardOrientation.LANDSCAPE,
      this.height,
      this.width,
      this.result,
      this.blurValue = 6.0,
      this.event});

  final CardType cardType;
  final CardOrientation orientation;
  final double? height;
  final double? width;
  final Result? result;
  final double blurValue;
  final void Function()? event;

  @override
  Widget build(BuildContext context) {
    final bool isPortrait = orientation == CardOrientation.POTRAIT;
    final Size size = getSize(isPortrait, height, width);
    final double borderRadius = (isPortrait ? 0.06 : 0.1) * size.height;
    final imagePath = isPortrait
        ? (result?.posterPath ?? result?.backdropPath ?? "")
        : (result?.backdropPath ?? result?.posterPath ?? "");
    final double textSize = (isPortrait ? 0.05 : 0.11) * size.height;
    final int maxLines = isPortrait ? 2 : 1;
    final decoration = BoxDecoration(color: AppColors.black5.withAlpha(70));

    ImageType imageType;
    String? imageUrl;
    Widget textCard;
    switch (cardType) {
      case CardType.GENRE:
        imageType = ImageType.LOCAL;
        imageUrl = imagePath;
        textCard = blurEffect(
            blurValue,
            Container(
                height: size.height,
                width: size.width,
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.symmetric(
                    horizontal: AppConstants.SIDE_PADDING,
                    vertical: 0.5 * AppConstants.SIDE_PADDING),
                decoration: decoration,
                child: CustomText(
                    text: result?.title ?? result?.originalTitle ?? "",
                    family: AppFonts.STAATLICHES,
                    size: 2.0 * textSize,
                    weight: FontWeight.w900,
                    maxLines: maxLines,
                    overflow: TextOverflow.ellipsis)),
            borderRadius: BorderRadius.circular(borderRadius));
        break;
      default:
        imageType = ImageType.REMOTE;
        imageUrl = getImageUrl(imagePath);
        textCard = blurEffect(
            blurValue,
            Container(
              height: 0.2 * size.height,
              width: width,
              alignment: Alignment.center,
              padding:
                  EdgeInsets.symmetric(horizontal: AppConstants.SIDE_PADDING),
              decoration: decoration,
              child: CustomText(
                text: result?.title ?? result?.originalTitle ?? "",
                size: textSize,
                weight: FontWeight.w900,
                maxLines: maxLines,
                align: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(borderRadius)));
        break;
    }

    return Stack(alignment: Alignment.bottomCenter, children: [
      CustomImage(
          imageType: imageType,
          imageUrl: imageUrl,
          event: event,
          borderRadius: BorderRadius.circular(borderRadius),
          height: size.height,
          width: size.width),
      IgnorePointer(child: textCard)
    ]);
  }

  Size getSize(bool isPortrait, double? height, double? width) {
    final double aspectRatio = isPortrait
        ? AppConstants.CARD_RATIO_PORTRAIT
        : AppConstants.CARD_RATIO_LANDSCAPE;

    double h, w;
    if (width != null) {
      h = width * aspectRatio;
      return Size(width, h);
    }

    h = height ?? (isPortrait ? 0.32.sh : 0.17.sh);
    w = h * aspectRatio;
    return Size(w, h);
  }
}
