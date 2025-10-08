import 'package:seven/app/app.dart';

class ChooseYourAvatarScreen extends ConsumerWidget {
  const ChooseYourAvatarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final profileController = ref.read(profileProvider.notifier);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) =>
          ref.invalidate(profileProvider),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.transparent,
            leading: CustomButton(
                buttonType: ButtonType.ICON,
                onPressed: () {
                  ref.invalidate(profileProvider);
                  context.pop();
                },
                icon: AppSvgs.ARROW_LEFT,
                forgroundColor: AppColors.lightSteel1,
                backgroundColor: AppColors.transparent,
                height: 0.04.sh),
            centerTitle: true,
            title: CustomText(
                text: "Choose your avatar",
                family: AppFonts.STAATLICHES,
                size: 0.04.sh)),
        body: Container(
          padding: const EdgeInsets.only(bottom: AppConstants.SIDE_PADDING),
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
              buildData("Name", ""),
              buildData("Phone number", " "),
              buildData("Email", " "),
              buildData("Data of Birth", " "),
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
                  await profileController.saveData();
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
            text: key,
            size: 0.016.sh,
            weight: FontWeight.w900,
            color: AppColors.lightSteel1.withAlpha(150)),
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
