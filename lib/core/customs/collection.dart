import 'package:seven/app/app.dart';

class CustomCollection extends StatelessWidget {
  const CustomCollection(
      {super.key,
      this.collectionName,
      required this.results,
      this.onPressed,
      this.isLoading = true,
      this.isSafeHeight = false,
      this.orientation = CardOrientation.LANDSCAPE,
      this.scrollDirection = Axis.horizontal,
      this.crossAxisCount = 1});

  final String? collectionName;
  final bool isLoading;
  final bool isSafeHeight;
  final List<Result>? results;
  final CardOrientation orientation;
  final Axis scrollDirection;
  final int crossAxisCount;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final bool isPortrait = orientation == CardOrientation.POTRAIT;
    final bool isVertical = scrollDirection == Axis.vertical;

    final double aspectRatio = isPortrait
        ? AppConstants.CARD_RATIO_PORTRAIT
        : AppConstants.CARD_RATIO_LANDSCAPE;
    final double height = isPortrait ? 0.32.sh : 0.17.sh;
    final double borderRadius = (isPortrait ? 0.06 : 0.1) * height;

    final collectionItems = GridView.builder(
        itemCount: results?.length ?? 5,
        scrollDirection: scrollDirection,
        padding: EdgeInsets.symmetric(
            horizontal: AppConstants.SIDE_PADDING,
            vertical: isVertical ? AppConstants.SIDE_PADDING : 0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppConstants.SIDE_PADDING,
            mainAxisSpacing: 0.5 * AppConstants.SIDE_PADDING,
            childAspectRatio: isVertical ? aspectRatio : 1 / aspectRatio),
        itemBuilder: (context, index) => ColoredBox(
            color: Colors.transparent, child: _buildCard(index, borderRadius)));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildText(context),
        SizedBox(
            height: isSafeHeight
                ? 1.sh - 74
                : crossAxisCount * height +
                    (crossAxisCount - 1) * AppConstants.SIDE_PADDING,
            child: collectionItems),
        SizedBox(height: isSafeHeight ? 0 : 0.05.sh),
      ],
    );
  }

  Widget _buildText(BuildContext context) {
    if (collectionName == null) return SizedBox.shrink();

    final textWidget = (isLoading)
        ? customShimmer(height: 0.03.sh, width: 0.5.sw, borderRadius: 0.01.sh)
        : CustomText(
            text: collectionName ?? "",
            family: AppFonts.STAATLICHES,
            size: 0.03.sh,
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
            children: [textWidget, seeAll])
        .paddingSymmetric(
            horizontal: AppConstants.SIDE_PADDING,
            vertical: AppConstants.SIDE_PADDING * 0.25);
  }

  Widget _buildCard(int index, double borderRadius) {
    if (isLoading) {
      return customShimmer(borderRadius: borderRadius);
    }

    return CustomCard(orientation: orientation, result: results?[index]);
  }
}
