import 'package:seven/app/app.dart';

class OnboadingScreen extends ConsumerWidget {
  const OnboadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageState = ref.watch(pageProvider);
    final pageController = ref.read(pageProvider.notifier);
    final onboarding = AppConstants.ONBOARDING;
    bool isLastIndex = pageState.currentIndex != onboarding.length - 1;

    Widget buildButton(int index) {
      final buttonNature =
          (DimensionUtil().deviceSize == DeviceSize.SMALL)
              ? ButtonNature.UNBOUND
              : ButtonNature.BOUND;

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
          height: 50.w,
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
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 70.w),
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
            SizedBox(height: 15.w),

            // DESCRIPTION
            CustomText(
                text: onboarding[index].string3 ?? "",
                align: TextAlign.end,
                color: AppColors.lightSteel1.withAlpha(150),
                size: 12.sp),
            SizedBox(height: 15.w),

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
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(onboarding[index].string1 ?? ""),
                        fit: BoxFit.cover)),
                child: buildChild(index))));
  }
}
