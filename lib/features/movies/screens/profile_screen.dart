import 'package:seven/app/app.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildButtons(bool isUserActive) {
      final height = 0.065.sh;
      final editButton = CustomButton(
          buttonType: ButtonType.ELEVATED,
          onPressed: () => context.push("/chooseYourAvatar"),
          height: height,
          backgroundColor: AppColors.vividNightfall4,
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const CustomText(
              text: "Edit profile",
              weight: FontWeight.w900,
            ),
            SizedBox(width: 0.02.sw),
            CustomImage(
                imageType: ImageType.SVG_LOCAL,
                imageUrl: AppSvgs.ARROW_RIGHT,
                height: 0.02.sh,
                color: AppColors.lightSteel1)
          ]));
      final logOutButton = CustomButton(
          buttonType: ButtonType.ELEVATED,
          onPressed: () {},
          height: height,
          backgroundColor: AppColors.red1.withAlpha(70),
          child: const CustomText(
            text: "Log out",
            color: AppColors.red1,
            weight: FontWeight.w900,
          ));

      return isUserActive
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: editButton),
                SizedBox(width: 0.02.sw),
                Expanded(child: logOutButton)
              ],
            )
          : editButton;
    }

    return Column(
      children: [
        CustomImage(
            imageType: ImageType.LOCAL,
            imageUrl: AppImages.AVATAR_1,
            height: 0.15.sh,
            borderRadius: BorderRadius.circular(1.sh)),
        SizedBox(height: 0.01.sh),
        if (true)
          CustomText(
              text: "Shubham Patel",
              family: AppFonts.STAATLICHES,
              size: 0.03.sh),
        if (true)
          CustomText(
              text: "Subhampatel8092@gmail.com",
              size: 0.015.sh,
              color: AppColors.lightSteel1.withAlpha(150)),
        SizedBox(height: 0.02.sh),
        buildButtons(false),
        SizedBox(height: 0.28.sh, child: contentList()),
        const Spacer(),
        CustomText(
            text: "Version 1.0.0",
            size: 0.015.sh,
            color: AppColors.lightSteel1.withAlpha(150))
      ],
    ).paddingFromLTRB(
        left: AppConstants.SIDE_PADDING,
        right: AppConstants.SIDE_PADDING,
        top: 4 * AppConstants.SIDE_PADDING,
        bottom: AppConstants.SIDE_PADDING);
  }

  Widget contentList() {
    return ListView.separated(
        itemCount: AppConstants.PROFILE.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 0.08.sh),
        itemBuilder: (_, index) => InkWell(
            onTap: () {},
            child: SizedBox(
                height: 0.07.sh,
                child: Row(
                  children: [
                    CustomImage(
                        imageType: ImageType.SVG_LOCAL,
                        imageUrl: AppConstants.PROFILE[index].icon,
                        height: 0.03.sh,
                        color: AppColors.vividNightfall4),
                    SizedBox(width: 0.04.sw),
                    CustomText(
                        text: AppConstants.PROFILE[index].title,
                        weight: FontWeight.w600),
                    const Spacer(),
                    if (index == 1)
                      CustomText(
                          text: "Disabled",
                          size: 0.015.sh,
                          color: AppColors.lightSteel1.withAlpha(150)),
                    SizedBox(width: 0.02.sw),
                    CustomImage(
                        imageType: ImageType.SVG_LOCAL,
                        imageUrl: AppSvgs.ARROW_RIGHT,
                        height: 0.02.sh,
                        color: AppColors.lightSteel1.withAlpha(150))
                  ],
                ))),
        separatorBuilder: (_, index) =>
            Divider(color: AppColors.black2, height: 0));
  }
}
