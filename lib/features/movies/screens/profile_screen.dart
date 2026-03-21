import 'package:seven/app/app.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.only(
            left: AppConstants.SIDE_PADDING,
            right: AppConstants.SIDE_PADDING,
            top: 5 * AppConstants.SIDE_PADDING,
            bottom: AppConstants.SIDE_PADDING + DimensionUtil().bottomBarHeight),
        child: Column(children: [
          Consumer(builder: (_, ref, __) {
            final profileState = ref.watch(profileProvider);
            final name = profileState.name;

            return Column(children: [
              CustomImage(
                  imageType: ImageType.LOCAL,
                  imageUrl: AppImages.AVATARS[profileState.profilePicIndex],
                  height: 120.w,
                  borderRadius: BorderRadius.circular(1000.r)),
              SizedBox(height: 8.w),
              if (name != null && name.isNotEmpty)
                CustomText(text: name, family: AppFonts.STAATLICHES, size: 24.w)
            ]);
          }),
          SizedBox(height: 16.w),
          buildButtons(context, false),
          // contentList(context),
          // CustomText(
          //     text: "Version 1.1.0",
          //     size: 0.015.sh,
          //     color: AppColors.lightSteel1.withAlpha(150))
        ]));
  }

  Widget buildButtons(BuildContext context, bool isUserActive) {
    final height = 50.w;
    final editButton = CustomButton(
        buttonType: ButtonType.ELEVATED,
        onPressed: () => context.push("/editProfile"),
        height: height,
        backgroundColor: AppColors.vividNightfall4,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          const CustomText(text: "Edit profile", weight: FontWeight.w900),
          SizedBox(width: 8.w),
          CustomImage(
              imageType: ImageType.SVG_LOCAL,
              imageUrl: AppSvgs.ARROW_RIGHT,
              height: 16.w,
              color: AppColors.lightSteel1)
        ]));
    final logOutButton = CustomButton(
        buttonType: ButtonType.ELEVATED,
        onPressed: () {},
        height: height,
        backgroundColor: AppColors.red1.withAlpha(70),
        child: const CustomText(
            text: "Log out", color: AppColors.red1, weight: FontWeight.w900));

    return isUserActive
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: editButton),
              SizedBox(width: 8.w),
              Expanded(child: logOutButton)
            ],
          )
        : editButton;
  }

  Widget contentList(BuildContext context) {
    return ListView.separated(
        itemCount: AppConstants.PROFILE.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 32.w),
        itemBuilder: (_, index) => InkWell(
            onTap: () {
              final route = AppConstants.PROFILE[index].string3;
              if (route != null) context.push(route);
            },
            child: SizedBox(
                height: 0.07.sh,
                child: Row(children: [
                  CustomImage(
                      imageType: ImageType.SVG_LOCAL,
                      imageUrl: AppConstants.PROFILE[index].string1,
                      height: 24.w,
                      color: AppColors.vividNightfall4),
                  SizedBox(width: 16.w),
                  CustomText(
                      text: AppConstants.PROFILE[index].string2 ?? "",
                      weight: FontWeight.w600),
                  const Spacer(),
                  if (index == 0)
                    CustomText(
                        text: "Disabled",
                        size: 14.w,
                        color: AppColors.lightSteel1.withAlpha(150)),
                  SizedBox(width: 8.w),
                  CustomImage(
                      imageType: ImageType.SVG_LOCAL,
                      imageUrl: AppSvgs.ARROW_RIGHT,
                      height: 16.w,
                      color: AppColors.lightSteel1.withAlpha(150))
                ]))),
        separatorBuilder: (_, index) =>
            Divider(color: AppColors.black2, height: 0));
  }
}
