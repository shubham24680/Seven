import 'package:seven/app/app.dart';

class ChooseYourAvatarScreen extends ConsumerWidget {
  const ChooseYourAvatarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final profileController = ref.read(profileProvider.notifier);

    Widget editData() {
      return Column(children: [
        CustomTextField(
            controller: profileState.nameController,
            hintText: "Name",
            filled: true),
        SizedBox(height: 0.02.sh),
        Row(children: [
          Expanded(
              child: CustomTextField(
                  textFieldType: TextFieldType.DROPDOWN,
                  onChanged: (value) {},
                  items: ["Male", "Female"],
                  hintText: "Gender",
                  suffixIcon: AppSvgs.PROFILE,
                  filled: true)),
          SizedBox(width: 0.02.sh),
          Expanded(
            child: CustomTextField(
                controller: profileState.dateOfBirthController,
                onTap: () {},
                hintText: "Date of birth",
                suffixIcon: AppSvgs.PROFILE,
                filled: true,
                readOnly: true),
          )
        ])
      ]);
    }

    Widget showData() {
      return (profileState.tryEditing)
          ? editData()
          : Column(children: [
              if (profileState.name != null)
                buildData("Name", profileState.name ?? "Shubham Patel"),
              if (profileState.gender != null)
                buildData("Gender", profileState.gender ?? "Male"),
              if (profileState.dateOfBirth != null)
                buildData("Data of Birth",
                    profileState.dateOfBirth ?? "11 July, 2001")
            ]);
    }

    void buildBottomSheet() {
      showModalBottomSheet(
          context: context,
          builder: (context) => GridView.builder(
                itemCount: AppAssets.AVATARS.length,
                padding: const EdgeInsets.all(AppConstants.SIDE_PADDING),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 0.03.sh,
                  crossAxisSpacing: 0.05.sw,
                ),
                itemBuilder: (context, index) {
                  return CustomImage(
                      imageType: ImageType.LOCAL,
                      event: () {
                        profileController.setIndexTo(index);
                        context.pop();
                      },
                      imageUrl: AppAssets.AVATARS[index],
                      borderRadius: BorderRadius.circular(1.sh));
                },
              ));
    }

    return PopScope(
        onPopInvokedWithResult: (didPop, result) =>
            ref.invalidate(profileProvider),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            extendBody: true,
            appBar: customAppBar(() {
              context.pop();
              ref.invalidate(profileProvider);
            }, "Edit Profile"),
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
                  // CustomImage(
                  //     imageType: ImageType.LOCAL,
                  //     imageUrl: AppAssets.AVATARS[profileState.profilePicIndex],
                  //     height: 0.25.sh,
                  //     width: 0.25.sh,
                  //     borderRadius: BorderRadius.circular(1.sh)),
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
                  showData(),
                  const Spacer(flex: 3),
                ])),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomButton(
                    onPressed: buildBottomSheet,
                    buttonType: ButtonType.ELEVATED,
                    backgroundColor: AppColors.lightSteel1.withAlpha(40),
                    height: 0.065.sh,
                    child: const CustomText(
                        text: "Choose your avatar", weight: FontWeight.w900)),
                SizedBox(height: 0.02.sh),
                CustomButton(
                    onPressed: () {
                      if (profileState.tryEditing) {
                        profileController.saveData();
                      } else {
                        profileController.loadIntoField();
                      }
                      profileController.toggle();
                    },
                    buttonType: ButtonType.ELEVATED,
                    backgroundColor: AppColors.vividNightfall4,
                    height: 0.065.sh,
                    child: CustomText(
                        text: profileState.tryEditing ? "Save" : "Edit",
                        weight: FontWeight.w900))
              ],
            ).paddingAll(AppConstants.SIDE_PADDING),
          ),
        ));
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
