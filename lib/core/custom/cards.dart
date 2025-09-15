import 'package:seven/app/app.dart';

enum CardOrientation { POTRAIT, LANDSCAPE }

class CustomCollection extends StatelessWidget {
  const CustomCollection(
      {super.key,
      required this.collectionName,
      required this.isLoading,
      required this.result,
      this.orientation = CardOrientation.LANDSCAPE});

  final String collectionName;
  final bool isLoading;
  final List<Result>? result;
  final CardOrientation orientation;
  final horizontalPadding = 15.0;
  final verticalPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    final height = orientation == CardOrientation.POTRAIT ? 0.5.sh : 0.17.sh;
    final margin = 0.03.sw;
    final aspectRatio = orientation == CardOrientation.POTRAIT ? 0.67 : 1.78;
    final width = height * aspectRatio;
    final borderRadius = height * 0.1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildText(),
        SizedBox(
          height: height,
          child: ListView.builder(
            itemCount: result?.length ?? 5,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: horizontalPadding),
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
            family: AppAssets.STAATLICHES,
            size: 0.03.sh,
          );

    return textWidget.paddingSymmetric(
        horizontal: horizontalPadding, vertical: verticalPadding);
  }

  Widget _buildCard(
      int index, double height, double width, double borderRadius) {
    final shimmer =
        customShimmer(height: height, width: width, borderRadius: borderRadius);

    if (isLoading) {
      return shimmer;
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CustomImage(
          imageUrl: result![index].backdropPath,
          borderRadius: BorderRadius.circular(borderRadius),
          placeholder: shimmer,
        ),
        if (result![index].title != null)
          blurEffect(
              3,
              Container(
                height: height * 0.2,
                width: width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: black5.withAlpha(70),
                ),
                child: CustomText(
                  text: result![index].title!,
                  size: height * 0.11,
                  align: TextAlign.center,
                  weight: FontWeight.w900,
                  maxLines: 1,
                ),
              ),
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(borderRadius))),
      ],
    );
  }
}
