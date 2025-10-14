import 'package:seven/app/app.dart';

enum CardOrientation { POTRAIT, LANDSCAPE }

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.orientation = CardOrientation.LANDSCAPE,
    this.isGenreCard = false,
    this.imageUrl,
    this.title,
    this.height,
    this.result,
  });

  final CardOrientation orientation;
  final bool isGenreCard;
  final String? imageUrl;
  final String? title;
  final double? height;
  final Result? result;

  @override
  Widget build(BuildContext context) {
    double aspectRatio = AppConstants.CARD_RATIO_LANDSCAPE;
    double widgetHeight = height ?? 0.17.sh;
    double textSize = 0.11;
    double borderRadius = 0.1;
    int maxLines = 1;
    String imagePath = result?.backdropPath ?? "";

    if (orientation == CardOrientation.POTRAIT) {
      aspectRatio = AppConstants.CARD_RATIO_PORTRAIT;
      widgetHeight = height ?? 0.32.sh;
      textSize = 0.05;
      borderRadius = 0.06;
      maxLines = 2;
      imagePath = result?.posterPath ?? "";
    }
    textSize *= widgetHeight;
    borderRadius *= widgetHeight;
    final width = widgetHeight * aspectRatio;

    Widget buildTextCard(String? title) {
      if (title == null) return SizedBox.shrink();

      return blurEffect(
          isGenreCard ? 6.0 : 6.0,
          Container(
            height: widgetHeight * (isGenreCard ? 1.0 : 0.2),
            width: width,
            alignment: isGenreCard ? Alignment.bottomLeft : Alignment.center,
            padding: EdgeInsets.symmetric(
                vertical: isGenreCard ? AppConstants.SIDE_PADDING : 0,
                horizontal: AppConstants.SIDE_PADDING),
            decoration: BoxDecoration(
              color: AppColors.black5.withAlpha(70),
            ),
            child: CustomText(
              text: title,
              family: isGenreCard ? AppFonts.STAATLICHES : null,
              size: textSize * (isGenreCard ? 2.0 : 1.0),
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
          imageType: isGenreCard ? ImageType.LOCAL : ImageType.REMOTE,
          imageUrl:
              isGenreCard ? imageUrl : ApiConstants.IMAGE_PATH + imagePath,
          borderRadius: BorderRadius.circular(borderRadius),
          height: widgetHeight,
          width: width,
        ),
        isGenreCard ? buildTextCard(title) : buildTextCard(result?.title)
      ],
    );
  }
}
