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
                  onChanged: (gender) {
                    final genderIndex = AppConstants.GENDER
                        .indexWhere((item) => item.string1 == gender);
                    if (genderIndex != -1) {
                      profileController.setGenderIndexTo(genderIndex);
                    }
                  },
                  items: AppConstants.GENDER
                      .map((item) => item.string1 ?? "")
                      .toList(),
                  initialValue: (profileState.genderIndex != -1)
                      ? AppConstants.GENDER[profileState.genderIndex].string1
                      : null,
                  hintText: "Gender",
                  suffixIcon: (profileState.genderIndex != -1)
                      ? AppConstants.GENDER[profileState.genderIndex].string2
                      : null,
                  filled: true)),
          SizedBox(width: 0.02.sh),
          Expanded(
            child: CustomTextField(
                controller: profileState.dateOfBirthController,
                onTap: () {},
                hintText: "DOB",
                suffixIcon: AppSvgs.CALENDAR,
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
              if (profileState.name != null && profileState.name!.isNotEmpty)
                buildData("Name", profileState.name ?? "Loading..."),
              if (profileState.genderIndex != -1)
                buildData(
                    "Gender",
                    AppConstants.GENDER[profileState.genderIndex].string1 ??
                        ""),
              if (profileState.dateOfBirth != null)
                buildData(
                    "Data of Birth", profileState.dateOfBirth ?? "Loading...")
            ]);
    }

    void buildBottomSheet() {
      final borderRadius = BorderRadius.vertical(top: Radius.circular(0.02.sh));
      final sheetColor = AppColors.lightSteel1;

      showModalBottomSheet(
          context: context,
          backgroundColor: sheetColor.withAlpha(10),
          barrierColor: AppColors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          isScrollControlled: true,
          builder: (context) => blurEffect(
              6.0,
              SingleChildScrollView(
                  padding: const EdgeInsets.all(AppConstants.SIDE_PADDING),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    CustomText(
                      text: "Choose your avatar",
                      family: AppFonts.STAATLICHES,
                      color: sheetColor.withAlpha(150),
                    ),
                    Divider(color: sheetColor.withAlpha(20)),
                    GridView.builder(
                        itemCount: AppAssets.AVATARS.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            vertical: AppConstants.SIDE_PADDING),
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 0.03.sh,
                            crossAxisSpacing: 0.05.sw),
                        itemBuilder: (context, index) {
                          return Stack(children: [
                            CustomImage(
                                imageType: ImageType.LOCAL,
                                event: () {
                                  profileController.setProfileIndexTo(index);
                                  context.pop();
                                },
                                imageUrl: AppAssets.AVATARS[index],
                                borderRadius: BorderRadius.circular(1.sh)),
                            if (index == profileState.profilePicIndex)
                              CustomImage(
                                  imageType: ImageType.SVG_LOCAL,
                                  imageUrl: AppSvgs.REMOVE_TO_FAVOURITE,
                                  height: double.infinity,
                                  color: AppColors.lightSteel1)
                          ]);
                        })
                  ])),
              borderRadius: borderRadius));
    }

    Widget bottomButton() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (profileState.tryEditing)
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
        ).paddingAll(AppConstants.SIDE_PADDING);

    return PopScope(
        onPopInvokedWithResult: (didPop, result) =>
            profileController.loadData(),
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
                extendBody: true,
                appBar: customAppBar(() {
                  context.pop();
                  profileController.loadData();
                }, "Edit Profile"),
                body: Container(
                    width: 1.sw,
                    padding: const EdgeInsets.all(AppConstants.SIDE_PADDING),
                    decoration: getDecoration(),
                    child: Column(children: [
                      CustomImage(
                          imageType: ImageType.LOCAL,
                          imageUrl:
                              AppAssets.AVATARS[profileState.profilePicIndex],
                          height: 0.25.sh,
                          width: 0.25.sh,
                          borderRadius: BorderRadius.circular(1.sh)),
                      const Spacer(),
                      showData(),
                      const Spacer(flex: 3),
                    ])),
                bottomNavigationBar: bottomButton())));
  }

  // Decoration
  BoxDecoration getDecoration() => BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            AppColors.transparent,
            AppColors.vividNightfall4.withAlpha(100)
          ]));

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
