import 'dart:developer';

import 'package:seven/app/app.dart';

class OnboadingScreen extends ConsumerWidget {
  const OnboadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageState = ref.watch(pageProvider);
    final pageController = ref.read(pageProvider.notifier);
    final onboarding = AppConstants.ONBOARDING;
    bool isLastIndex = pageState.currentIndex != onboarding.length - 1;

    log("deviceWidth - ${DimensionUtil().deviceWidth}\n"
        "deviceHeight - ${DimensionUtil().deviceHeight}\n "
        "scaleWidth - ${DimensionUtil().scaleWidth}\n"
        "scaleHeight - ${DimensionUtil().scaleHeight}\n"
        "scaleMin - ${DimensionUtil().scaleMin}\n"
        "isFoldable - ${DimensionUtil().isFoldable}\n"
        "isLandscape - ${DimensionUtil().isLandscape}\n");

    Widget buildButton(int index) {
      final buttonNature = (DimensionUtil().isLandscape || DimensionUtil().isFoldable) ? ButtonNature.BOUND : ButtonNature.UNBOUND;

      return CustomButton(
          buttonType: ButtonType.ELEVATED,
          buttonNature: buttonNature,
          onPressed: () {
            if (index + 1 < onboarding.length) {
              pageController.jumpToPage(pageState.currentIndex + 1);
            } else {
              pageController.changeFirstTimeVisitStatus();
              context.go('/');
            }
          },
          height: 50.h,
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            CustomText(
                text: isLastIndex ? "Next" : "Get the vibe",
                weight: FontWeight.w900),
            SizedBox(width: 15.w),
            CustomImage(
                imageType: ImageType.SVG_LOCAL,
                imageUrl: AppSvgs.ARROW_RIGHT,
                height: 16.sp,
                color: AppColors.lightSteel1)
          ]));
    }

    buildChild(int index) {
      return SingleChildScrollView(
        reverse: true,
        padding: EdgeInsets.symmetric(
            horizontal: 15.w, vertical: 50.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // HEADING
            CustomText(
                text: onboarding[index].string2 ?? "",
                align: TextAlign.end,
                family: AppFonts.STAATLICHES,
                size: 32.sp,
                weight: FontWeight.w900,
                height: 1.3),
            SizedBox(height: 15.h),

            // DESCRIPTION
            CustomText(
                text: onboarding[index].string3 ?? "",
                align: TextAlign.end,
                color: AppColors.lightSteel1.withAlpha(150),
                size: 12.sp),
            SizedBox(height: 15.h),

            // NEXT BUTTON
            buildButton(index)
          ],
        ),
      );
    }

    return Scaffold(
        body: PageView.builder(
            controller: pageState.pageController,
            itemCount: onboarding.length,
            onPageChanged: (index) => pageController.moveToPage(index),
            itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(onboarding[index].string1 ?? ""),
                        fit: BoxFit.cover)),
                child: buildChild(index))));
  }
}
