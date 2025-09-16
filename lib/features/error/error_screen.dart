import 'package:seven/app/app.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "oh no!",
              family: AppAssets.STAATLICHES,
              size: 0.04.sh,
            ),
            CustomText(
              text:
                  "No internet connection.\nCheck your network and try again.",
              size: 0.015.sh,
            ),
          ],
        ).paddingSymmetric(horizontal: 20),
        SvgPicture.asset(
          AppAssets.NO_INTERNET,
          width: 1.sw,
        ),
        CustomElevatedButton(child: CustomText(text: "Try again"))
            .paddingSymmetric(horizontal: 20)
      ],
    );
  }
}
