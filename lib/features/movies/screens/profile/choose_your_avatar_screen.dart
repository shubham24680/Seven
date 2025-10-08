import 'package:seven/app/app.dart';

class ChooseYourAvatarScreen extends ConsumerWidget {
  const ChooseYourAvatarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final profileController = ref.read(profileProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.symmetric(vertical: AppConstants.SIDE_PADDING),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                AppColors.transparent,
                AppColors.vividNightfall4.withAlpha(100)
              ])),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomImage(
                    imageType: ImageType.SVG_LOCAL,
                    imageUrl: AppSvgs.ARROW_LEFT,
                    color: AppColors.lightSteel1,
                    height: 36,
                    event: () => context.pop(),
                  ),
                  const CustomText(
                      text: "Choose your avatar",
                      family: AppFonts.STAATLICHES,
                      size: 36),
                  SizedBox(width: 0.07.sw)
                ],
              ).paddingSymmetric(horizontal: AppConstants.SIDE_PADDING),
              const Spacer(),
              CarouselSlider(
                  items: generateImage(),
                  options: CarouselOptions(
                      onPageChanged: (index, reason) =>
                          profileController.setIndexTo(index),
                      initialPage: profileState.profilePicIndex,
                      height: 0.25.sh,
                      viewportFraction: 0.55,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.8,
                      enableInfiniteScroll: false)),
              const Spacer(),
              // const Spacer(),
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: CustomText(
              //       text: "Avatar",
              //       size: 0.016.sh,
              //       weight: FontWeight.w900,
              //       color: AppColors.lightSteel1.withAlpha(150)),
              // ).paddingSymmetric(horizontal: AppConstants.SIDE_PADDING),
              // SizedBox(height: 0.02.sh),
              // CarouselSlider(
              //     items: generateImage(),
              //     options: CarouselOptions(
              //         onPageChanged: (index, reason) {
              //           setState(() {
              //             initialIndex = index;
              //           });
              //         },
              //         initialPage: initialIndex,
              //         height: 0.1.sh,
              //         viewportFraction: 0.25,
              //         padEnds: false,
              //         enableInfiniteScroll: false)),
              const Spacer(),
              CustomButton(
                onPressed: () {},
                buttonType: ButtonType.ELEVATED,
                backgroundColor: AppColors.lightSteel1.withAlpha(40),
                height: 0.065.sh,
                child: const CustomText(
                  text: "Edit",
                  weight: FontWeight.w900,
                ),
              ).paddingSymmetric(horizontal: AppConstants.SIDE_PADDING),
              SizedBox(height: 0.02.sh),
              CustomButton(
                onPressed: () async {
                  await profileController.save();
                  context.pop();
                },
                buttonType: ButtonType.ELEVATED,
                backgroundColor: AppColors.vividNightfall4,
                height: 0.065.sh,
                child: const CustomText(
                  text: "Save",
                  weight: FontWeight.w900,
                ),
              ).paddingSymmetric(horizontal: AppConstants.SIDE_PADDING)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildData(String key, String value) {
    return Row(
      children: [
        CustomText(
            text: key,
            size: 0.016.sh,
            weight: FontWeight.w900,
            color: AppColors.lightSteel1.withAlpha(150)),
        const Spacer(),
        CustomText(text: value, size: 0.016.sh, weight: FontWeight.w900),
      ],
    ).paddingSymmetric(
        horizontal: AppConstants.SIDE_PADDING, vertical: 0.01.sh);
  }

  List<CustomImage> generateImage() {
    return List.generate(
        AppAssets.AVATARS.length,
        (index) => CustomImage(
            imageType: ImageType.LOCAL,
            imageUrl: AppAssets.AVATARS[index],
            borderRadius: BorderRadius.circular(1.sh)));
  }
}
