import 'package:seven/app/app.dart';

class ChooseYourAvatarScreen extends ConsumerWidget {
  const ChooseYourAvatarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final profileController = ref.read(profileProvider.notifier);

    void bottomSheet() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColors.lightSteel1.withAlpha(20),
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadiusGeometry.vertical(top: Radius.circular(0.02.sh))),
        builder: (context) {
          return blurEffect(
              3.0,
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(controller: profileState.nameController),
                  SizedBox(height: 0.02.sh),
                  CustomTextField(controller: profileState.nameController),
                  SizedBox(height: 0.02.sh),
                  CustomTextField(controller: profileState.nameController),
                  SizedBox(height: 0.02.sh),
                  CustomTextField(controller: profileState.nameController),
                ],
              ).paddingFromLTRB(
                  left: AppConstants.SIDE_PADDING,
                  top: AppConstants.SIDE_PADDING,
                  right: AppConstants.SIDE_PADDING,
                  bottom: AppConstants.SIDE_PADDING +
                      MediaQuery.of(context).viewInsets.bottom),
              borderRadius: BorderRadius.circular(0.02.sh));
        },
      );
    }

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
                child: Column(children: [
                  const Spacer(),
                  // CarouselSlider(
                  //     items: generateImage(),
                  //     options: CarouselOptions(
                  //         onPageChanged: (index, reason) =>
                  //             profileController.setIndexTo(index),
                  //         initialPage: profileState.profilePicIndex,
                  //         height: 0.25.sh,
                  //         viewportFraction: 0.55,
                  //         enlargeCenterPage: true,
                  //         enlargeFactor: 0.8,
                  //         enableInfiniteScroll: false)),
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
                  CustomTextField(controller: profileState.nameController),
                  SizedBox(height: 0.02.sh),
                  CustomButton(
                      buttonType: ButtonType.ELEVATED,
                      onPressed: bottomSheet,
                      backgroundColor: AppColors.lightSteel1.withAlpha(40),
                      height: 0.065.sh,
                      child: const CustomText(
                          text: "Edit", weight: FontWeight.w900)),
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
                          text: "Save", weight: FontWeight.w900))
                ]))));
  }

  List<CustomImage> generateImage() {
    return List.generate(
        AppAssets.AVATARS.length,
        (index) => CustomImage(
            imageType: ImageType.LOCAL,
            imageUrl: AppAssets.AVATARS[index],
            borderRadius: BorderRadius.circular(1.sh)));
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
}
