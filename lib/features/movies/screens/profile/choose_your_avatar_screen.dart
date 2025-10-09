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
        appBar: customAppBar(() {
          ref.invalidate(profileProvider);
          context.pop();
        }, "Choose your avatar"),
        body: Container(
          padding: const EdgeInsets.all(AppConstants.SIDE_PADDING),
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
              if (profileState.name != null)
                buildData("Name", profileState.name ?? ""),
              if (profileState.phoneNumber != null)
                buildData("Phone number", profileState.phoneNumber ?? ""),
              if (profileState.email != null)
                buildData("Email", profileState.email ?? ""),
              if (profileState.dateOfBirth != null)
                buildData("Data of Birth", profileState.dateOfBirth ?? ""),
              const Spacer(),
              CustomButton(
                buttonType: ButtonType.ELEVATED,
                onPressed: () {},
                backgroundColor: AppColors.lightSteel1.withAlpha(40),
                height: 0.065.sh,
                child: const CustomText(
                  text: "Edit",
                  weight: FontWeight.w900)),
              SizedBox(height: 0.02.sh),
              CustomButton(
                onPressed: () async {
                  await profileController.saveData();
                  context.pop(); //USE MOUNTED IN ASYNC GAPS.
                },
                buttonType: ButtonType.ELEVATED,
                backgroundColor: AppColors.vividNightfall4,
                height: 0.065.sh,
                child: const CustomText(
                  text: "Save",
                  weight: FontWeight.w900))
            ])))
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
    ).paddingSymmetric(vertical: 0.01.sh);
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
