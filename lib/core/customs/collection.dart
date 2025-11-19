import 'package:seven/app/app.dart';

class CustomCollection extends StatelessWidget {
  const CustomCollection(
      {super.key,
      this.scrollController,
      this.scrollDirection = Axis.horizontal,
      this.crossAxisCount = 1,
      this.isLoading = true,
      this.loadingItemCount = 3,
      this.collectionName,
      this.cardType = CardType.SHOWS,
      this.orientation = CardOrientation.LANDSCAPE,
      this.onPressed,
      this.results,
      this.blurValue = 6.0,
      this.screenPath = "/detail/",
      this.isSafeHeight = false});

  final ScrollController? scrollController;
  final Axis scrollDirection;
  final int crossAxisCount;
  final bool isSafeHeight;
  final bool isLoading;
  final int loadingItemCount;
  final String? collectionName;
  final void Function()? onPressed;
  final CardType cardType;
  final CardOrientation orientation;
  final List<Result>? results;
  final double blurValue;
  final String screenPath;

  @override
  Widget build(BuildContext context) {
    final bool isPortrait = orientation == CardOrientation.POTRAIT;
    final bool isVertical = scrollDirection == Axis.vertical;

    final double aspectRatio = isPortrait
        ? AppConstants.CARD_RATIO_PORTRAIT
        : AppConstants.CARD_RATIO_LANDSCAPE;
    final double height = isPortrait ? 0.32.sh : 0.17.sh;
    final double width =
        (1.sw - (crossAxisCount + 1) * AppConstants.SIDE_PADDING) /
            crossAxisCount;
    final double borderRadius = (isPortrait ? 0.06 : 0.1) * height;
    final double verticalPadding = MediaQuery.of(context).padding.top;

    Widget buildCard(int index) {
      if (index >= (results?.length ?? 0)) {
        return customShimmer(borderRadius: borderRadius);
      }

      return CustomCard(
          cardType: cardType,
          orientation: orientation,
          height: isVertical ? null : height,
          width: isVertical ? width : null,
          results: results?[index],
          blurValue: blurValue,
          event: () => context.push("$screenPath${results?[index].id}"));
    }

    final collectionItems = GridView.builder(
        controller: scrollController,
        scrollDirection: scrollDirection,
        itemCount: (results?.length ?? 0) + (isLoading ? loadingItemCount : 0),
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.only(
          left: AppConstants.SIDE_PADDING,
          right: AppConstants.SIDE_PADDING,
          top: isVertical ? verticalPadding : 0,
          bottom: isVertical ? AppConstants.SIDE_PADDING : 0,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 0.5 * AppConstants.SIDE_PADDING,
            mainAxisSpacing: 0.5 * AppConstants.SIDE_PADDING,
            childAspectRatio: isVertical ? aspectRatio : 1 / aspectRatio),
        itemBuilder: (context, index) => buildCard(index));

    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildText(),
          isSafeHeight
              ? Flexible(child: collectionItems)
              : SizedBox(
                  height: crossAxisCount * height +
                      (crossAxisCount - 1) * AppConstants.SIDE_PADDING,
                  child: collectionItems),
          SizedBox(height: isSafeHeight ? 0 : 0.05.sh)
        ]);
  }

  Widget buildText() {
    if (collectionName == null) return SizedBox.shrink();

    final textWidget = (isLoading)
        ? customShimmer(height: 0.03.sh, width: 0.5.sw, borderRadius: 0.01.sh)
        : Expanded(
            child: CustomText(
              text: collectionName ?? "",
              family: AppFonts.STAATLICHES,
              size: 0.03.sh,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          );

    final seeAll = (isLoading)
        ? customShimmer(height: 0.03.sh, width: 0.1.sw, borderRadius: 0.01.sh)
        : CustomButton(
            buttonType: ButtonType.TEXT,
            onPressed: onPressed,
            icon: "See all",
          );

    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [textWidget, SizedBox(width: 0.02.sw), seeAll])
        .paddingSymmetric(
            horizontal: AppConstants.SIDE_PADDING,
            vertical: AppConstants.SIDE_PADDING * 0.25);
  }
}
