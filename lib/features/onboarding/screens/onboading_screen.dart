import 'package:seven/app/app.dart';

class OnboadingScreen extends ConsumerWidget {
  const OnboadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageState = ref.watch(pageProvider);
    final pageController = ref.read(pageProvider.notifier);
    bool isLastIndex =
        pageState.currentIndex != AppConstants.ONBOARDING_TEXT.length - 1;

    // MARK: Heading
    buildHeading(int index, {double? size}) {
      return CustomText(
        text: AppConstants.ONBOARDING_TEXT[index]['heading']!,
        align: TextAlign.end,
        family: AppAssets.STAATLICHES,
        size: size ?? 16.sp,
        weight: FontWeight.w900,
        height: 1.3,
      );
    }

    // MARK: Child
    buildChild(int index) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // HEADING
          buildHeading(index, size: 32.sp),
          const SizedBox(height: 20),

          // DESCRIPTION
          CustomText(
            text: AppConstants.ONBOARDING_TEXT[index]['description']!,
            align: TextAlign.end,
            color: lightSteel1.withAlpha(170),
            size: 12.sp,
          ),
          const SizedBox(height: 20),

          // NEXT BUTTON
          CustomElevatedButton(
            onPressed: () {
              if (index + 1 < AppConstants.ONBOARDING_TEXT.length) {
                pageController.jumpToPage(pageState.currentIndex + 1);
              } else {
                context.go('/movies');
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                CustomText(
                  text: isLastIndex ? "Next     " : "Get the vibe     ",
                  size: 14.sp,
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 14.sp,
                  color: lightSteel1,
                ),
              ],
            ),
          ),
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
          padding: EdgeInsets.only(bottom: 60.h, right: 20.w, left: 20.w),
          decoration: BoxDecoration(
            // BACKGROUND IMAGE
            image: DecorationImage(
              image: AssetImage(AppAssets.ONBOARDING_IMAGES[index]),
              fit: BoxFit.cover,
              alignment: const Alignment(-0.4, 0.0),
            ),
          ),
          child: buildChild(index),
        ),
      ),
    );
  }
}
