import 'package:seven/app/app.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

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
                family: AppAssets.STAATLICHES,
                size: 0.04.sh),
            CustomText(text: errorData.subtitle, size: 0.015.sh)
          ],
        ),
        SvgPicture.asset(errorData.image,
            width: 1.sw), //TODO: Replace with CustomImage
        CustomButton(
            buttonType: ButtonType.ELEVATED,
            height: 0.065.sh,
            child:
                CustomText(text: errorData.buttonText, weight: FontWeight.w900))
      ],
    ).paddingSymmetric(horizontal: AppConstants.SIDE_PADDING);
  }
}
