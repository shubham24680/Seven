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
      this.results,
      this.blurValue = 6.0,
      this.event});

  final CardType cardType;
  final CardOrientation orientation;
  final double? height;
  final double? width;
  final Result? results;
  final double blurValue;
  final void Function()? event;

  @override
  Widget build(BuildContext context) {
    final bool isPortrait = orientation == CardOrientation.POTRAIT;
    final Size size = getSize(isPortrait, height, width);
    final double borderRadius = (isPortrait ? 0.06 : 0.1) * size.height;
    final imagePath = isPortrait
        ? (results?.posterPath ?? results?.backdropPath ?? "")
        : (results?.backdropPath ?? results?.posterPath ?? "");
    final double textSize = (isPortrait ? 0.05 : 0.11) * size.height;
    final int maxLines = isPortrait ? 2 : 1;
    final decoration = BoxDecoration(color: AppColors.black5.withAlpha(70));

    ImageType imageType;
    String? imageUrl;
    Widget cardChild;
    switch (cardType) {
      case CardType.GENRE:
        imageType = ImageType.LOCAL;
        imageUrl = imagePath;
        cardChild = blurEffect(
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
                    text: results?.title ?? results?.originalTitle ?? "",
                    family: AppFonts.STAATLICHES,
                    size: 2 * textSize,
                    weight: FontWeight.w900,
                    maxLines: maxLines,
                    overflow: TextOverflow.ellipsis)),
            borderRadius: BorderRadius.circular(borderRadius));
        break;
      default:
        imageType = ImageType.REMOTE;
        imageUrl = getImageUrl(imagePath);
        final adult = results?.adult == true;
        final voteAverage = results?.voteAverage;
        final tags =
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          if (adult)
            CustomTag(
                tagSize: TagSize.SMALL,
                value: "18+",
                backgroundColor: AppColors.black3.withAlpha(70)),
          SizedBox(width: 0.01 * size.height),
          if (voteAverage != null && voteAverage != "0.0")
            CustomTag(
                tagSize: TagSize.SMALL, icon: AppSvgs.STAR, value: voteAverage),
        ]).paddingAll(0.05 * size.height);
        final textCard = blurEffect(
            blurValue,
            Container(
                height: 0.2 * size.height,
                width: width,
                alignment: Alignment.center,
                padding:
                    EdgeInsets.symmetric(horizontal: AppConstants.SIDE_PADDING),
                decoration: decoration,
                child: CustomText(
                  text: results?.title ?? results?.originalTitle ?? "",
                  size: textSize,
                  weight: FontWeight.w900,
                  maxLines: maxLines,
                  align: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                )),
            borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(borderRadius)));
        cardChild = Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [tags, textCard]);
        break;
    }

    return Stack(alignment: Alignment.bottomCenter, children: [
      CustomImage(
          imageType: imageType,
          imageUrl: imageUrl,
          onClick: event,
          borderRadius: BorderRadius.circular(borderRadius),
          height: size.height,
          width: size.width),
      IgnorePointer(child: cardChild)
    ]);
  }

  Size getSize(bool isPortrait, double? height, double? width) {
    final double aspectRatio = isPortrait
        ? AppConstants.CARD_RATIO_PORTRAIT
        : AppConstants.CARD_RATIO_LANDSCAPE;

    double h, w;
    if (width != null) {
      h = width / aspectRatio;
      return Size(width, h);
    }

    h = height ?? (isPortrait ? 0.32.sh : 0.17.sh);
    w = h * aspectRatio;
    return Size(w, h);
  }
}
