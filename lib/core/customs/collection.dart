import 'package:seven/app/app.dart';

class CustomCollection extends StatelessWidget {
  const CustomCollection({
    super.key,
    required this.collectionName,
    required this.isLoading,
    required this.result,
    this.orientation = CardOrientation.LANDSCAPE,
    this.scrollDirection = Axis.horizontal,
  });

  final String collectionName;
  final bool isLoading;
  final List<Result>? result;
  final CardOrientation orientation;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    final aspectRatio = orientation == CardOrientation.POTRAIT
        ? AppConstants.CARD_RATIO_PORTRAIT
        : AppConstants.CARD_RATIO_LANDSCAPE;
    final height = orientation == CardOrientation.POTRAIT ? 0.32.sh : 0.17.sh;
    final width = height * aspectRatio;
    final borderRadius = height * 0.1;
    final margin = 0.03.sw;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildText(),
        SizedBox(
          height: height,
          child: ListView.builder(
            itemCount: result?.length ?? 5,
            scrollDirection: scrollDirection,
            padding: const EdgeInsets.only(left: AppConstants.SIDE_PADDING),
            itemBuilder: (context, index) => SizedBox(
              width: width,
              child: _buildCard(index, height, width, borderRadius),
            ).paddingFromLTRB(right: margin),
          ),
        ),
        SizedBox(height: 0.05.sh),
      ],
    );
  }

  Widget _buildText() {
    final textWidget = (isLoading)
        ? customShimmer(height: 0.03.sh, width: 0.5.sw, borderRadius: 0.01.sh)
        : CustomText(
            text: collectionName,
            family: AppFonts.STAATLICHES,
            size: 0.03.sh,
          );

    return textWidget.paddingSymmetric(
        horizontal: AppConstants.SIDE_PADDING,
        vertical: AppConstants.SIDE_PADDING * 0.25);
  }

  Widget _buildCard(
      int index, double height, double width, double borderRadius) {
    if (isLoading) {
      return customShimmer(
          height: height, width: width, borderRadius: borderRadius);
    }

    return CustomCard(orientation: orientation, result: result?[index]);
  }
}
