import 'package:seven/app/app.dart';

class Shows extends ConsumerWidget {
  const Shows({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(showsProvider);
    final navigationController = ref.read(showsProvider.notifier);
    final searchState = ref.watch(searchProvider(searchWithTitle));

    buildIcon(String icon, int index) {
      return SvgPicture.asset(icon,
          colorFilter: ColorFilter.mode(
              (index == navigationState.navigationCurrentIndex)
                  ? AppColors.vividNightfall4
                  : AppColors.black1,
              BlendMode.srcIn));
    }

    bool getCondition() {
      switch (navigationState.navigationCurrentIndex) {
        case 1:
          return searchState.crossFadeState;
        default:
          return navigationState.crossFadeState;
      }
    }

    final bottomIcon = AppAssets.BOTTOM_NAVIGATION_ICONS;
    final items = List.generate(
        bottomIcon.length,
        (index) => BottomNavigationBarItem(
            label: "Item$index",
            icon: buildIcon(bottomIcon[index].icon, index)));

    final bottomNavigationBar = BottomNavigationBar(
        onTap: (index) => navigationController.moveToPage(index),
        currentIndex: navigationState.navigationCurrentIndex,
        backgroundColor: AppColors.black4,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: items);

    return Scaffold(
        body: bottomIcon[navigationState.navigationCurrentIndex].screen,
        bottomNavigationBar: AnimatedCrossFade(
            firstChild: bottomNavigationBar,
            secondChild: const SizedBox.shrink(),
            crossFadeState: getCondition()
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 300)));
  }
}

// (showsState.navigationCurrentIndex !=
//                   AppAssets.BOTTOM_NAVIGATION_ICONS.length - 1 &&
//               showsState.status.isError)
//           ? ErrorScreen(
//               onPressed: () => showsController.refresh(), isHomePage: true)
//           :
