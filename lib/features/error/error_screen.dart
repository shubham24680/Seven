import 'package:seven/app/app.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, this.onPressed});

  final void Function()? onPressed;

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
                text: errorData.title,
                family: AppFonts.STAATLICHES,
                size: 0.04.sh),
            CustomText(text: errorData.subtitle, size: 0.015.sh)
          ],
        ),
        CustomImage(
          imageType: ImageType.SVG_LOCAL,
          imageUrl: errorData.image,
        ),
        CustomButton(
            buttonType: ButtonType.ELEVATED,
            backgroundColor: AppColors.vividNightfall4,
            height: 0.065.sh,
            onPressed: onPressed,
            child:
                CustomText(text: errorData.buttonText, weight: FontWeight.w900))
      ],
    ).paddingSymmetric(horizontal: AppConstants.SIDE_PADDING);
  }
}
