import 'dart:math' as math;
import 'package:seven/app/app.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard(
      {super.key,
      this.width,
      this.isLoading = true,
      this.firstTeamColor,
      this.secondTeamColor,
      this.match});

  final double? width;
  final bool isLoading;
  final Color? firstTeamColor;
  final Color? secondTeamColor;
  final Item? match;
  static const _sidePadding = AppConstants.SIDE_PADDING;

  @override
  Widget build(BuildContext context) {
    final height = (width ?? 1.sw) / AppConstants.CARD_RATIO_LANDSCAPE;
    if (isLoading) {
      return customShimmer(height: height, borderRadius: 0.1 * height);
    }

    final teamA = match?.teama;
    final teamB = match?.teamb;
    final logoA = teamA?.logoUrl;
    final logoB = teamB?.logoUrl;
    final nameA = teamA?.name ?? teamA?.shortName;
    final nameB = teamB?.name ?? teamB?.shortName;
    final scoreA = teamA?.scoresFull;
    final scoreB = teamB?.scoresFull;
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(0.1 * height),
        gradient: SweepGradient(
            endAngle: math.pi,
            center: Alignment.topCenter,
            colors: [
              secondTeamColor ?? AppColors.vividNightfall4,
              AppColors.black3,
              AppColors.black3,
              firstTeamColor ?? AppColors.vividNightfall4
            ]));

    return Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(1),
        decoration: decoration,
        child: Stack(
          children: [
            _buildLighting(height),
            Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                    color: AppColors.transparent,
                    borderRadius: BorderRadius.circular(0.1 * height)),
                child: Column(
                  children: [
                    Expanded(
                        child: Row(children: [
                      _buildTeamVs(height, logoA, nameA, scoreA),
                      CustomImage(
                          imageType: ImageType.LOCAL,
                          imageUrl: "assets/images/vs.png",
                          width: 0.1 * height),
                      _buildTeamVs(height, logoB, nameB, scoreB),
                    ])),
                    // Container(
                    //   height: 2,
                    //   decoration: BoxDecoration(
                    //       gradient: LinearGradient(colors: [
                    //     AppColors.transparent,
                    //     AppColors.black1,
                    //     AppColors.transparent
                    //   ])),
                    // ),
                    // SizedBox(height: 0.5 * _sidePadding),
                    // Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: CustomText(
                    //         text: "107 run need in 100 balls", size: 10.w)),
                    // SizedBox(height: 0.5 * _sidePadding),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 2 * _sidePadding),
                        child: ClipPath(
                            clipper: TrapeziumClipper(),
                            child: Container(
                              color: AppColors.black2.withAlpha(100),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2 * _sidePadding,
                                  vertical: 0.25 * _sidePadding),
                              child: CustomText(
                                  text: match?.statusNote ?? "",
                                  size: 10.w,
                                  align: TextAlign.center,
                                  maxLines: 1),
                            )))
                  ],
                ))
          ],
        ));
  }

  Widget _buildLighting(double height) {
    return Row(children: [
      _buildGradient(height,
          [firstTeamColor ?? AppColors.vividNightfall4, AppColors.black3]),
      _buildGradient(height,
          [secondTeamColor ?? AppColors.vividNightfall4, AppColors.black3],
          isRight: true)
    ]);
  }

  Widget _buildGradient(double height, List<Color> colors,
      {bool isRight = false}) {
    final borderRadius = BorderRadius.horizontal(
        left: isRight ? Radius.zero : Radius.circular(0.1 * height),
        right: isRight ? Radius.circular(0.1 * height) : Radius.zero);

    return Expanded(
        child: Container(
            height: height,
            decoration: BoxDecoration(
                borderRadius: borderRadius,
                gradient: RadialGradient(
                    center: isRight ? Alignment.topRight : Alignment.topLeft,
                    radius: 1,
                    colors: colors))));
  }

  Widget _buildTeamVs(
      double height, String? flag, String? name, String? score) {
    return Expanded(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipOval(
            child: CustomImage(
                imageType: ImageType.REMOTE,
                imageUrl: flag,
                fit: BoxFit.cover,
                height: 0.3 * height,
                width: 0.3 * height)),
        SizedBox(height: _sidePadding),
        if (name != null && name.isNotEmpty)
          CustomText(
              text: name,
              size: 12.w,
              maxLines: 1,
              color: AppColors.lightSteel1.withAlpha(150)),
        CustomText(
            text: score ?? "",
            size: 12.w,
            color: AppColors.lightSteel1,
            weight: FontWeight.w900),
      ],
    ));
  }
}

class TrapeziumClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, size.height); // bottom-left
    path.lineTo(size.width * 0.1, 0); // top-left
    path.lineTo(size.width * 0.9, 0); // top-right
    path.lineTo(size.width, size.height); // bottom-right

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
