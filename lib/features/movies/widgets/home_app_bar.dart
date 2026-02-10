import '../../../app/app.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileIndex = ref.watch(profileProvider).profilePicIndex;
    final showController = ref.watch(showsProvider.notifier);
    final topPadding =
        DimensionUtil().statusBarHeight;
    
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      CustomImage(
          imageType: ImageType.LOCAL,
          imageUrl: AppImages.AVATARS[profileIndex],
          height: 36.w,
          borderRadius: BorderRadius.circular(1.sw),
          onClick: () => showController
              .moveToPage(AppConstants.BOTTOM_NAVIGATION.length - 1)),
      CustomButton(
          buttonType: ButtonType.ICON,
          icon: AppSvgs.SEARCH_OUTLINED,
          onPressed: () => context.push("/searchCollection"))
    ]).paddingFromLTRB(
        left: AppConstants.SIDE_PADDING,
        top: topPadding,
        right: AppConstants.SIDE_PADDING);
  }
}
