import 'package:seven/app/app.dart';

enum CardOrientation { POTRAIT, LANDSCAPE }

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key,
      this.orientation = CardOrientation.LANDSCAPE,
      this.isGenreCard = false,
      this.imageUrl,
      this.title,
      this.height,
      this.result,
      this.event});

  final CardOrientation orientation;
  final bool isGenreCard;
  final String? imageUrl;
  final String? title;
  final double? height;
  final Result? result;
  final void Function()? event;

  @override
  Widget build(BuildContext context) {
    final bool isPortrait = orientation == CardOrientation.POTRAIT;
    final int maxLines = isPortrait ? 2 : 1;
    final String imagePath =
        isPortrait ? (result?.posterPath ?? "") : (result?.backdropPath ?? "");
    final double widgetHeight = height ?? (isPortrait ? 0.32.sh : 0.17.sh);
    final double aspectRatio = isPortrait
        ? AppConstants.CARD_RATIO_PORTRAIT
        : AppConstants.CARD_RATIO_LANDSCAPE;
    final double textSize = (isPortrait ? 0.05 : 0.11) * widgetHeight;
    final double borderRadius = (isPortrait ? 0.06 : 0.1) * widgetHeight;
    final double width = widgetHeight * aspectRatio;

    final ImageType imageType =
        isGenreCard ? ImageType.LOCAL : ImageType.REMOTE;
    final String resolvedImageUrl =
        isGenreCard ? (imageUrl ?? "") : (ApiConstants.IMAGE_PATH + imagePath);
    final String? effectiveTitle =
        isGenreCard ? title : (result?.title ?? result?.originalTitle);

    Widget buildTextCard(String? cardTitle) {
      if (cardTitle == null) return const SizedBox.shrink();

      final double containerHeight = widgetHeight * (isGenreCard ? 1.0 : 0.2);
      final Alignment alignment =
          isGenreCard ? Alignment.bottomLeft : Alignment.center;
      final double computedTextSize = textSize * (isGenreCard ? 2.0 : 1.0);

      return blurEffect(
          6.0,
          Container(
            height: containerHeight,
            width: width,
            alignment: alignment,
            padding: EdgeInsets.symmetric(
                vertical: isGenreCard ? AppConstants.SIDE_PADDING : 0,
                horizontal: AppConstants.SIDE_PADDING),
            decoration: BoxDecoration(
              color: AppColors.black5.withAlpha(70),
            ),
            child: CustomText(
              text: cardTitle,
              family: isGenreCard ? AppFonts.STAATLICHES : null,
              size: computedTextSize,
              weight: FontWeight.w900,
              maxLines: maxLines,
              align: isGenreCard ? null : TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(isGenreCard ? borderRadius : 0),
              bottom: Radius.circular(borderRadius)));
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CustomImage(
          imageType: imageType,
          imageUrl: resolvedImageUrl,
          event: event,
          borderRadius: BorderRadius.circular(borderRadius),
          height: widgetHeight,
          width: width,
        ),
        buildTextCard(effectiveTitle)
      ],
    );
  }
}
