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
      this.screenPath = "/detail",
      this.type = "movie",
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
  final String? type;

  @override
  Widget build(BuildContext context) {
    final bool isPortrait = orientation == CardOrientation.POTRAIT;
    final bool isVertical = scrollDirection == Axis.vertical;
    final incresedCount =
        DimensionUtil().deviceSize == DeviceSize.SMALL ? 1 : 2;
    final double aspectRatio = isPortrait
        ? AppConstants.CARD_RATIO_PORTRAIT
        : AppConstants.CARD_RATIO_LANDSCAPE;
    final double height = isPortrait ? 250.w : 150.w;
    final double width = (1.sw -
            (incresedCount * crossAxisCount + 1) * AppConstants.SIDE_PADDING) /
        (incresedCount * crossAxisCount);
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
          event: () {
            final query = {
              "path": (results?[index].mediaType ?? type ?? "").toLowerCase(),
              "id": results?[index].id.toString(),
            };
            context.push(screenPath, extra: query);
          });
    }

    final itemCount =
        (results?.length ?? 0) + (isLoading ? loadingItemCount : 0);
    final collectionItems = GridView.builder(
        controller: scrollController,
        scrollDirection: scrollDirection,
        itemCount: itemCount,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.only(
            left: AppConstants.SIDE_PADDING,
            right: AppConstants.SIDE_PADDING,
            top: isVertical ? verticalPadding : 0,
            bottom: isVertical
                ? AppConstants.SIDE_PADDING + DimensionUtil().bottomBarHeight
                : 0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: incresedCount * crossAxisCount,
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
                  height: incresedCount * crossAxisCount * height +
                      (incresedCount * crossAxisCount - 1) *
                          AppConstants.SIDE_PADDING,
                  child: collectionItems),
          SizedBox(height: isSafeHeight ? 0 : 24.w)
        ]);
  }

  Widget buildText() {
    if (collectionName == null) return SizedBox.shrink();

    final textWidget = isLoading
        ? customShimmer(height: 20.w, width: 200.w, borderRadius: 6.w)
        : Expanded(
            child: CustomText(
                text: collectionName ?? "",
                family: AppFonts.STAATLICHES,
                size: 24.w,
                maxLines: 1,
                overflow: TextOverflow.ellipsis));

    final seeAll = isLoading
        ? customShimmer(height: 20.w, width: 50.w, borderRadius: 6.w)
        : CustomButton(
            buttonType: ButtonType.TEXT, onPressed: onPressed, icon: "See all");

    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [textWidget, SizedBox(width: 20.w), seeAll])
        .paddingSymmetric(
            horizontal: AppConstants.SIDE_PADDING,
            vertical: AppConstants.SIDE_PADDING * 0.25);
  }
}
