import 'package:seven/app/app.dart';

class Shows extends ConsumerWidget {
  const Shows({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showsState = ref.watch(showsProvider);
    final showsController = ref.read(showsProvider.notifier);

    if (showsState.status.isInitial) {
      Future.microtask(() {
        showsController.loadAllData();
      });
    }

    Widget buildIcon(String icon, int index) {
      return SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
            (index == showsState.navigationCurrentIndex)
                ? AppColors.vividNightfall4
                : AppColors.black1,
            BlendMode.srcIn),
      );
    }

    return Scaffold(
      body: (showsState.navigationCurrentIndex !=
                  AppAssets.BOTTOM_NAVIGATION_ICONS.length - 1 &&
              showsState.status.isError)
          ? ErrorScreen(onPressed: () => showsController.refresh())
          : AppAssets.BOTTOM_NAVIGATION_ICONS[showsState.navigationCurrentIndex]
              .screen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => showsController.moveToPage(index),
        currentIndex: showsState.navigationCurrentIndex,
        backgroundColor: AppColors.black4,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: List.generate(
          AppAssets.BOTTOM_NAVIGATION_ICONS.length,
          (index) => BottomNavigationBarItem(
            icon:
                buildIcon(AppAssets.BOTTOM_NAVIGATION_ICONS[index].icon, index),
            label: "Item$index",
          ),
        ),
      ),
    );
  }
}
