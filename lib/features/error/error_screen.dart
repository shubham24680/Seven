import 'package:seven/app/app.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, this.onPressed, this.isHomePage = false});

  final void Function()? onPressed;
  final bool isHomePage;

  @override
  Widget build(BuildContext context) {
    final errorData = AppConstants.ERRORDATA;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: errorData.string1 ?? "",
                family: AppFonts.STAATLICHES,
                size: 0.04.sh),
            CustomText(text: errorData.string2 ?? "", size: 0.015.sh)
          ],
        ),
        CustomImage(
          imageType: ImageType.SVG_LOCAL,
          imageUrl: errorData.string3,
        ),
        Column(
          children: [
            buildButton(errorData.string4, onTap: onPressed),
            if (!isHomePage) ...[
              SizedBox(height: 0.01.sh),
              buildButton(errorData.string5,
                  color: AppColors.lightSteel1.withAlpha(40),
                  onTap: () => context.pop()),
            ]
          ],
        )
      ],
    ).paddingSymmetric(horizontal: AppConstants.SIDE_PADDING);
  }

  Widget buildButton(String? value,
      {Color color = AppColors.vividNightfall4, Function()? onTap}) {
    if (value == null) return SizedBox.shrink();

    return CustomButton(
        buttonType: ButtonType.ELEVATED,
        backgroundColor: color,
        height: 0.065.sh,
        onPressed: onTap,
        child: CustomText(text: value, weight: FontWeight.w900));
  }
}
