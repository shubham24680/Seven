import '../../../app/app.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screensStates = ref.watch(mainProvider);
    final screensController = ref.read(mainProvider.notifier);
    final screens = screensStates.screens;
    final bottomIcon = screens.widgets;
    final style = screens.style;

    buildIcon(AppModel? model, int index) {
      final shimmer =
          customShimmer(height: 20.w, width: 20.w, borderRadius: 6.r);
      final color = (index == screensStates.navigationCurrentIndex)
          ? parseColor(style?.selectedColor,
              defaultColor: AppColors.vividNightfall4)
          : parseColor(style?.unselectedColor, defaultColor: AppColors.black1);

      return SvgPicture.network(
          getImageUrl(model?.iconUrl, imagePath: model?.type) ?? "",
          placeholderBuilder: (context) => shimmer,
          errorBuilder: (context, error, stackTrace) => shimmer,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn));
    }

    final items = List.generate(
        bottomIcon?.length ?? 3,
        (index) => BottomNavigationBarItem(
            label: bottomIcon?[index].id ?? "Item_$index",
            icon: buildIcon(bottomIcon?[index], index)));

    final bottomNavigationBar = BottomNavigationBar(
        onTap: (index) {
          if (bottomIcon != null) {
            screensController.moveToPage(index);
          }
        },
        currentIndex: screensStates.navigationCurrentIndex,
        backgroundColor:
            parseColor(style?.backgroundColor, defaultColor: AppColors.black4),
        showSelectedLabels: screens.showSelectedLabels ?? false,
        showUnselectedLabels: screens.showUnselectedLabels ?? false,
        type: BottomNavigationBarType.fixed,
        items: items);

    return Scaffold(
        body: mainScreen[bottomIcon?[screensStates.navigationCurrentIndex].id ?? "home"],
        bottomNavigationBar: AnimatedCrossFade(
            firstChild: bottomNavigationBar,
            secondChild: const SizedBox.shrink(),
            crossFadeState: false
                // navigationState.crossFadeState
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 300)));
  }
}
