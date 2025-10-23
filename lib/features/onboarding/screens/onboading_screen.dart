import 'package:seven/app/app.dart';

class OnboadingScreen extends ConsumerWidget {
  const OnboadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageState = ref.watch(pageProvider);
    final pageController = ref.read(pageProvider.notifier);
    bool isLastIndex =
        pageState.currentIndex != AppConstants.ONBOARDING_TEXT.length - 1;

    // MARK: Child
    buildChild(int index) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // HEADING
          CustomText(
              text: AppConstants.ONBOARDING_TEXT[index]['heading']!,
              align: TextAlign.end,
              family: AppFonts.STAATLICHES,
              size: 32.sp,
              weight: FontWeight.w900,
              height: 1.3),
          SizedBox(height: 0.02.sh),

          // DESCRIPTION
          CustomText(
              text: AppConstants.ONBOARDING_TEXT[index]['description']!,
              align: TextAlign.end,
              color: AppColors.lightSteel1.withAlpha(150),
              size: 12.sp),
          SizedBox(height: 0.02.sh),

          // NEXT BUTTON
          CustomButton(
              buttonType: ButtonType.ELEVATED,
              onPressed: () {
                if (index + 1 < AppConstants.ONBOARDING_TEXT.length) {
                  pageController.jumpToPage(pageState.currentIndex + 1);
                } else {
                  pageController.changeFirstTimeVisitStatus();
                  context.go('/');
                }
              },
              height: 0.065.sh,
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                CustomText(
                  text: isLastIndex ? "Next" : "Get the vibe",
                  weight: FontWeight.w900,
                ),
                SizedBox(width: 0.02.sw),
                CustomImage(
                    imageType: ImageType.SVG_LOCAL,
                    imageUrl: AppSvgs.ARROW_RIGHT,
                    height: 0.02.sh,
                    color: AppColors.lightSteel1)
              ]))
        ],
      );
    }

    // MARK: Scaffold
    return Scaffold(
        body: PageView.builder(
            controller: pageState.pageController,
            itemCount: AppConstants.ONBOARDING_TEXT.length,
            onPageChanged: (index) => pageController.moveToPage(index),
            itemBuilder: (context, index) => Container(
                width: 1.sw,
                padding: EdgeInsets.only(
                    bottom: 60.h,
                    right: AppConstants.SIDE_PADDING,
                    left: AppConstants.SIDE_PADDING),
                decoration: BoxDecoration(
                    // BACKGROUND IMAGE
                    image: DecorationImage(
                        image: AssetImage(AppAssets.ONBOARDING_IMAGES[index]),
                        fit: BoxFit.cover,
                        alignment: const Alignment(-0.4, 0.0))),
                child: buildChild(index))));
  }
}
